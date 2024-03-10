return {
	{ "folke/neodev.nvim", ft = { "lua" } },
	--  {
	-- 	"folke/trouble.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("trouble").setup({
	-- 			use_diagnostic_signs = true,
	-- 		})
	-- 		vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
	-- 		vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
	-- 		vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
	-- 		vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
	-- 		vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
	-- 		vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
	-- 	end
	-- },
	{ "neovim/nvim-lspconfig", event = "VeryLazy" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		-- dependencies = {
		-- 	"hoIsSethDaniel/mason-tool-installer.nvim",
		-- 	config = function()
		-- 		-- stylua: ignore start
		-- 		local ensure_installed = {
		-- 			-- LSP
		-- 			--  "ast_grep",'gopls','clangd','marksman','lua_ls','tsserver','jdtls','cssls', 'html', ,
		-- 			"bashls", "clangd", "lua_ls", "jdtls", "jsonls", "ltex", "pyright", "vimls", "yamlls",
		-- 			--  Linter
		-- 			--  Formatter
		-- 			"black", "clang-format", "isort", "prettier", "stylua", --  "yamlfix",
		-- 		}

		-- 		require("mason-tool-installer").setup({
		-- 			ensure_installed = ensure_installed,
		-- 		})
		-- 	end,
		-- },
	},
	-- {
	-- 	"lvimuser/lsp-inlayhints.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("lsp-inlayhints").setup({
	-- 			inlay_hints = {
	-- 				parameter_hints = {
	-- 					show = true,
	-- 					prefix = "<- ",
	-- 					separator = ", ",
	-- 					remove_colon_start = false,
	-- 					remove_colon_end = true,
	-- 				},
	-- 				type_hints = {
	-- 					-- type and other hints
	-- 					show = true,
	-- 					prefix = "",
	-- 					separator = ", ",
	-- 					remove_colon_start = false,
	-- 					remove_colon_end = false,
	-- 				},
	-- 				only_current_line = false,
	-- 				-- separator between types and parameter hints. Note that type hints are
	-- 				-- shown before parameter
	-- 				labels_separator = "  ",
	-- 				-- whether to align to the length of the longest line in the file
	-- 				max_len_align = false,
	-- 				-- padding from the left if max_len_align is true
	-- 				max_len_align_padding = 1,
	-- 				highlight = "Comment",
	-- 			},
	-- 		})
	-- 		vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			group = "LspAttach_inlayhints",
	-- 			callback = function(args)
	-- 				if not (args.data and args.data.client_id) then
	-- 					return
	-- 				end
	-- 				local bufnr = args.buf
	-- 				local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 				require("lsp-inlayhints").on_attach(client, bufnr)
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"smjonas/inc-rename.nvim",
	-- 	config = function()
	-- 		require("inc_rename").setup()
	-- 	end,
	-- },
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({ library = { plugins = {} } })
			-- vim.cmd([[MasonInstall black clang-format isort prettier stylua ]])
			require("mason").setup({
				ui = {
					border = "rounded", -- "none", "single", "double", "rounded",  "solid", "shadow"
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				github = {
					download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
				},
				pip = {
					install_args = { "-i https://pypi.tuna.tsinghua.edu.cn/simple" },
				},
			})
			-- stylua: ignore start
			local servers = { -- only LSP supported
				-- LSP
				--  "ast_grep",'gopls','clangd','marksman','lua_ls','tsserver','jdtls','cssls', 'html', ,
				"bashls", "clangd", "lua_ls", "jdtls", "jsonls", "ltex", "pyright", "vimls", "yamlls",
				--  Linter
				--  Formatter
				-- "black", "clang-format", "isort", "prettier", "stylua", "yamlfix",
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
			capabilities.textDocument.foldingRange = { -- For nvim-ufo  use
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
			require('lspconfig.ui.windows').default_options.border = "rounded"
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				}
			})
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "VeryLazy",
	-- 	-- opts = {},
	-- 	config = function()
	-- 		require("lsp_signature").setup()
	-- 		-- config.lsp.signature.enabled = false
	-- 		-- vim.keymap.set({ "n" }, "<c-s-k>", function()
	-- 		-- 	require("lsp_signature").toggle_float_win()
	-- 		-- end, { silent = true, noremap = true, desc = "toggle signature" })
	-- 	end,
	-- },
}
