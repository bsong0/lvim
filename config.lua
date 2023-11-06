vim.loader.enable()
lvim.builtin.luasnip.active = false
lvim.builtin.indentlines.active = false
lvim.lsp.installer.setup.automatic_installation = false

lvim.builtin.treesitter.indent = {
    disable = { "cpp" }
}


lvim.lsp.automatic_configuration.skipped_servers = {
    "clangd", "rust_analyzer"
}

lvim.lazy.opts.performance.cache = { enabled = true }
lvim.lsp.installer.setup.automatic_installation = false

require('autocommands')
require('plugins')
require('keymaps')
require('theme')
require('misc')
