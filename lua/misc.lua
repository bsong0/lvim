vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.api.nvim_set_option("clipboard", "unnamed")
