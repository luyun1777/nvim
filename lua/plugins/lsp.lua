return {
	{
		"neovim/nvim-lspconfig",
		event = "User LazyLoad",
		dependencies = {
			{ "folke/lazydev.nvim", opts = {} },
			-- { "folke/neodev.nvim", ft = { "lua" } },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- require("neodev").setup({ library = { plugins = {} } })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.foldingRange = { -- For nvim-ufo  use
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			require("lspconfig.ui.windows").default_options.border = "rounded"
			require("mason-lspconfig").setup({
				ensure_installed = {},
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
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
			},
			github = { download_url_template = "https://ghproxy.cc/https://github.com/%s/releases/download/%s/%s" },
			ensure_installed = {},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
