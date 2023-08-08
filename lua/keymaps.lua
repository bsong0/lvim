lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["q:"] = "<nop>"
lvim.keys.normal_mode["Q"] = "<nop>"

lvim.keys.insert_mode["jk"] = "<ESC>"

lvim.keys.command_mode["w!!"] = "w !sudo tee > /dev/null %"

lvim.keys.normal_mode["<leader>ss"] = "<cmd>Lspsaga finder tyd+ref+imp+def<CR>"
lvim.keys.normal_mode["<leader>lci"] = ":Lspsaga incoming_calls<CR>"
lvim.keys.normal_mode["<leader>lco"] = ":Lspsaga outgoing_calls<CR>"
lvim.keys.normal_mode['gf'] = '<cmd>Lspsaga code_action<CR>'
lvim.keys.normal_mode["[E"] = function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end
lvim.keys.normal_mode["]E"] = function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end
lvim.lsp.buffer_mappings.normal_mode["K"] = { '<cmd>Lspsaga hover_doc<CR>', "Hover" }
