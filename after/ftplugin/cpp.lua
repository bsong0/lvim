local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "clang_format" }
}
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet") then
        return
    end

    notify(msg, ...)
end

vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>')
vim.keymap.set('n', 'gf', ':Lspsaga code_action')

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

require "lsp_signature".setup({})
