lvim.builtin.luasnip.active = false

require('autocommands')
require('plugins')
require('keymaps')
lvim.colorscheme = "nord"

vim.api.nvim_set_option("clipboard", "unnamed")

lvim.builtin.treesitter.indent = {
    disable = { "cpp" }
}

vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.tabstop = 4
vim.o.shiftwidth = 4

local list_snips = function()
	local ft_list = require("luasnip").available()[vim.o.filetype]
	local ft_snips = {}
	for _, item in pairs(ft_list) do
		ft_snips[item.trigger] = item.name
	end
	print(vim.inspect(ft_snips))
end

vim.api.nvim_create_user_command("SnipList", list_snips, {})
