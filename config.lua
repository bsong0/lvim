vim.loader.enable()
lvim.builtin.luasnip.active = false
lvim.builtin.indentlines.active = false

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

