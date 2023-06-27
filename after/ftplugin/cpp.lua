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
vim.keymap.set('n', 'gf', ':lua vim.lsp.buf.code_action()<CR>')
lvim.builtin.treesitter.indent = {
  disable = { "cpp" }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "cppcheck",
    args = { "--enable=warning,style,performance,portability", "--template=gcc", "$FILENAME", "--std" }
  }
}