vim.loader.disable()
lvim.builtin.luasnip.active = false
lvim.builtin.indentlines.active = false

lvim.builtin.treesitter.indent = {
    disable = { "cpp" }
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
    "clangd",
})

lvim.lazy.opts.performance.cache = { enabled = true }

require('autocommands')
require('plugins')
require('keymaps')
require('theme')
require('misc')

