return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm" },
		keys = {
			{ "<c-t>" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle ToggleTerm" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "ToggleTerm horizontal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", desc = "ToggleTerm vertical" },
			-- { "<leader>gg", "<cmd>lua Toggle_Lazygit()<cr>", desc = "ToggleTerm Lazygit" },
		},
		opts = {
			direction = "float",
			shading_factor = 2,
			float_opts = { border = "curved" },
			open_mapping = [[<c-t>]],
		},
		-- init = function()
		-- 	local Terminal = require("toggleterm.terminal").Terminal

		-- 	local _lazygit = Terminal:new({ cmd = "lazygit", hidden = true, dir = "git_dir", direction = "float" })

		-- 	function Toggle_Lazygit()
		-- 		if vim.fn.executable("lazygit") == 1 then
		-- 			_lazygit:toggle()
		-- 		else
		-- 			vim.notify("**lazygit** is not founded in PATH, please install it.", vim.log.levels.WARN)
		-- 		end
		-- 	end
		-- end,
	},
	-- {
	-- 	"Vigemus/iron.nvim",
	-- 	keys = {
	-- 		{ "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
	-- 		{ "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },
	-- 		{ "<leader>sl", desc = "󱠤 Send Line to REPL" },
	-- 		{ "<leader>sf", desc = "󱠤 Send File to REPL" },
	-- 	},
	-- 	config = function()
	-- 		local iron = require("iron.core")
	-- 		iron.setup({
	-- 			config = {
	-- 				repl_definition = {
	-- 					sh = { command = { "zsh" } },
	-- 				},
	-- 				repl_open_cmd = "horizontal bot 20 split",
	-- 			},
	-- 			keymaps = {
	-- 				send_file = "<leader>sf",
	-- 				send_line = "<leader>sl",
	-- 				exit = "<leader>sq",
	-- 			},
	-- 			ignore_blank_lines = true,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"ibhagwan/fzf-lua",
	-- 	cmd = "FzfLua",
	-- 	opts = {},
	-- 	keys = {
	-- 		{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
	-- 		{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
	-- 		{
	-- 			"<leader>,",
	-- 			"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
	-- 			desc = "Switch Buffer",
	-- 		},
	-- 		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
	-- 		-- find
	-- 		{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
	-- 		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
	-- 		{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
	-- 		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
	-- 		-- git
	-- 		{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
	-- 		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
	-- 		-- search
	-- 		{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
	-- 		{ "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
	-- 		{ "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
	-- 		{ "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
	-- 		{ "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
	-- 		{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
	-- 		{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
	-- 		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
	-- 		{ "<leader>sG", "<cmd>FzfLua live_grep_native<cr>", desc = "Live Grep (performant version)" },
	-- 		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Live Grep(cword)" },
	-- 		{ "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Live Grep (cWORD)" },
	-- 		{ "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help Pages" },
	-- 		{ "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
	-- 		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
	-- 		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
	-- 		{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
	-- 		{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
	-- 		{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
	-- 		{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
	-- 		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
	-- 		{ "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbol" },
	-- 		{ "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Symbol ( Workspace )" },

	-- 		{ "<leader>uc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme" },
	-- 	},
	-- },
}
