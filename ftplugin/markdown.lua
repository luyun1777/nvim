vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = false

local function opts(desc)
	return { noremap = true, silent = true, buffer = 0, nowait = true, desc = desc or "" }
end
local map = vim.keymap.set

map("i", "<m-p>", "<++>", opts("Placeholder"))
map("i", "<m-f>", '<esc>/<++><cr>:nohlsearch<cr>"_c4l', opts("Search Placeholder"))
map("i", "<m-F>", '<esc>/ <++><cr>:nohlsearch<cr>"_c4l', opts("Search Placeholder"))
map("n", "<m-f>", '/<++><cr>:nohlsearch<cr>"_c4l', opts("Search Placeholder"))
map("n", "<m-F>", '/ <++><cr>:nohlsearch<cr>"_c4l', opts("Search Placeholder"))
map("i", "<m-i>", "** <++><esc>F*i", opts("Italic"))
map("i", "<m-s>", "~~~~ <++><esc>F~hi", opts("Strikethrough"))
map("i", "<m-b>", "**** <++><esc>F*hi", opts("Bold"))
map("i", "<m-u>", "<u></u> <++><esc>F/hi", opts("Underline"))
map("i", "<m-c>", "```<cr><++><cr>```<cr><cr><++><esc>4kA", opts("Code block"))
map("i", "<m-a>", "[](<++>) <++><esc>F[a", opts("Link"))
map("i", "<m-l>", "---<cr>", opts("Line break"))
map("i", "<m-p>", "![](<++>) <++><esc>F[a", opts("Picture"))
map("i", "<m-1>", "# ", opts("Heading 1"))
map("i", "<m-2>", "## ", opts("Heading 2"))
map("i", "<m-3>", "### ", opts("Heading 3"))
map("i", "<m-4>", "#### ", opts("Heading 4"))
map("i", "<m-5>", "##### ", opts("Heading 5"))
map("i", "<m-6>", "###### ", opts("Heading 6"))
