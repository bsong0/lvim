local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "clang_format" }
}
-- local notify = vim.notify
-- vim.notify = function(msg, ...)
--   if msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet") then
--     return
--   end

--   notify(msg, ...)
-- end

vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>')

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        name = "cpplint",
    }
}
if os.getenv("USE_2_INDENT") then
    vim.o.tabstop = 2
    vim.opt.shiftwidth = 2
end

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
end)

-- require "lsp_signature".setup({})

-- BEGIN CLANGD SETUP
local opts = {}
local clangd_flags = {
    "--background-index",
    "--fallback-style=google",
    "-j=12",
    "--all-scopes-completion",
    "--pch-storage=memory",
    "--clang-tidy",
    "--log=error",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--enable-config",
    "--offset-encoding=utf-16",
    "--ranking-model=heuristics",
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
    clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
    require("lvim.lsp").common_on_init(client, bufnr)
    require("clangd_extensions.config").setup {}
    require("clangd_extensions.ast").init()
    vim.cmd [[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]]
end

opts = {
    cmd = { provider, unpack(clangd_flags) },
    on_attach = custom_on_attach,
    on_init = custom_on_init,
}
require("lvim.lsp.manager").setup("clangd", opts)
-- END CLANGD SETUP
--
local cmp = require("cmp")
lvim.builtin.cmp.sorting = {
    comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
}
