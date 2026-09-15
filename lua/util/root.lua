---@class util.root
local M = {}

---@type (string|string[])[]
M.root_markers = {
	".git",
	{ "Makefile", "CMakeLists.txt", ".clang-format" },
	"Cargo.toml",
	"go.mod",
	{ "pyproject.toml", "setup.py", "requirements.txt" }, -- Python
	{ "package.json", "deno.json", "deno.jsonc" },
	{ ".luarc.json", ".luarc.jsonc", "stylua.toml", "lazy-lock.json" },
}

--- Cache keyed by `<bufnr>|<marker-fingerprint>` so different marker sets
--- don't collide.
---@type table<string, string>
local cache = {}

--- Pick the best root for a buffer.
--- Prefers roots that are an exact path-prefix of `bufpath` (deepest wins);
--- otherwise falls back to the longest root.
---@param roots string[]
---@param bufpath string|nil
---@return string|nil
local function pick_best(roots, bufpath)
	if #roots == 0 then
		return nil
	end
	if #roots == 1 then
		return roots[1]
	end

	if bufpath and bufpath ~= "" then
		local best
		for _, r in ipairs(roots) do
			if bufpath:sub(1, #r) == r then
				local next_char = bufpath:sub(#r + 1, #r + 1)
				if next_char == "" or next_char == "/" or next_char == "\\" then
					if not best or #r > #best then
						best = r
					end
				end
			end
		end
		if best then
			return best
		end
	end

	table.sort(roots, function(a, b)
		return #a > #b
	end)
	return roots[1]
end

--- Stable serialization of a marker list for use as a cache key.
--- Does not mutate the input.
---@param markers (string|string[])[]
---@return string
local function markers_key(markers)
	local parts = {}
	for _, m in ipairs(markers) do
		if type(m) == "table" then
			local sub = {}
			for i, s in ipairs(m) do
				sub[i] = s
			end
			table.sort(sub)
			parts[#parts + 1] = table.concat(sub, "\1")
		else
			parts[#parts + 1] = m
		end
	end
	table.sort(parts)
	return table.concat(parts, "\2")
end

---@param bufnr integer
---@param bufpath string  normalized buffer path
---@return string|nil
local function get_lsp_root(bufnr, bufpath)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if not clients or #clients == 0 then
		return nil
	end

	clients = vim.tbl_filter(function(client)
		return not vim.tbl_contains(vim.g.root_lsp_ignore or {}, client.name)
	end, clients) --[[@as vim.lsp.Client[] ]]

	local roots = {} ---@type string[]
	for _, client in ipairs(clients) do
		-- Neovim 0.11+ exposes the root via `client.config.root_dir`;
		-- older versions also set `client.root_dir`. Prefer the former.
		local root = (client.config and client.config.root_dir) or client.root_dir

		-- Fall back to workspace folders (some servers only report these).
		if not root and client.workspace_folders and client.workspace_folders[1] then
			local uri = client.workspace_folders[1].uri
			if uri then
				root = vim.uri_to_fname(uri)
			end
		end

		if root and root ~= "" then
			roots[#roots + 1] = vim.fs.normalize(root)
		end
	end

	if #roots == 0 then
		return nil
	end

	return pick_best(roots, bufpath)
end

---@param bufpath string|integer
---@param markers (string|string[])[]
---@return string|nil
local function get_fs_root(bufpath, markers)
	local root = vim.fs.root(bufpath, markers)
	return root and vim.fs.normalize(root) or nil
end

--- Clear all cached entries for a given buffer (or all buffers if nil).
-- Invalidate every cache entry belonging to this buffer, across
-- all marker fingerprints.
---@param bufnr? integer
function M.clear_cache(bufnr)
	if bufnr then
		local prefix = bufnr .. "|"
		local plen = #prefix
		for k in pairs(cache) do
			if k:sub(1, plen) == prefix then
				cache[k] = nil
			end
		end
	else
		cache = {}
	end
end

--- Resolution order: cache > LSP root_dir > vim.fs.root() > current_dir.
---@param opts? { bufnr?:integer, markers?:(string|string[])[], refresh?:boolean, prefer_lsp?:boolean }
---@return string
function M.get(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local markers = opts.markers or M.root_markers

	if not vim.api.nvim_buf_is_valid(bufnr) then
		return vim.fn.getcwd()
	end

	local bufpath = vim.api.nvim_buf_get_name(bufnr)
	if bufpath == "" then
		bufpath = vim.fn.getcwd()
	end
	bufpath = vim.fs.normalize(bufpath)

	local key = bufnr .. "|" .. markers_key(markers)

	if opts.refresh then
		cache[key] = nil
	end

	local cached = cache[key]
	if cached then
		return cached
	end

	local root
	if opts.prefer_lsp ~= false then
		root = get_lsp_root(bufnr, bufpath)
	end
	if not root then
		root = get_fs_root(bufpath, markers)
	end
	if not root then
		root = vim.fn.getcwd()
	end

	cache[key] = root
	return root
end

return M
