lvim.builtin.cmp.active = false
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = 'latexindent', args = { '-g', '/dev/null', '-' } } }
