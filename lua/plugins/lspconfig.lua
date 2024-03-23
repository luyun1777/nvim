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
	},
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
				pip = { install_args = { "-i", "https://pypi.tuna.tsinghua.edu.cn/simple" } },
			})
			-- stylua: ignore start
			local servers = { -- only LSP supported
				-- LSP
				--  "ast_grep",'gopls','clangd','marksman','lua_ls','tsserver','jdtls','cssls', 'html', ,
				"bashls", "clangd", "lua_ls", "jsonls", "ltex", "pyright", "rust_analyzer", "vimls"
				--  Linter
				--  Formatter
				-- "black", "clang-format", "isort", "prettier", "prettier", "stylua", "yamlfix",
			}
			-- stylua: ignore end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.foldingRange = { -- For nvim-ufo  use
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			require("lspconfig.ui.windows").default_options.border = "rounded"
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}
