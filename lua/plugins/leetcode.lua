return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- telescope 所需
		"MunifTanjim/nui.nvim",

		-- 可选
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- 配置放在这里
		lang = "java",
		-- lang = "python3",
		cn = {
			enabled = true,
		},
		injector = {
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" },
				after = "int main() {}",
			},
			["java"] = {
				before = "import java.util.*;",
			},
		},
	},
}
