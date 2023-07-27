vim.api.nvim_set_option("clipboard", "unnamed")

lvim.plugins = {
    {
        'ethanholz/nvim-lastplace',
        config = function()
            require 'nvim-lastplace'.setup {
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true
            }
        end
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = "Neogen",
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    },
    {
        "klen/nvim-config-local",
        config = function()
            require('config-local').setup {
                -- Default options (optional)

                -- Config file patterns to load (lua supported)
                config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

                -- Where the plugin keeps files data
                hashfile = vim.fn.stdpath("data") .. "/config-local",

                autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
                commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
                silent = false,             -- Disable plugin messages (Config loaded/ignored)
                lookup_parents = true,      -- Lookup config files in parent directories
            }
        end
    },
    { "AlexvZyl/nordic.nvim" },
    { "shaunsingh/nord.nvim" },
    { "luisiacc/gruvbox-baby" },
    {
        "kylechui/nvim-surround",

        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "junegunn/vim-easy-align",
        keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } } },
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        dependencies = { "tpope/vim-repeat" },
        config = function()
            require('leap').add_default_mappings()
        end
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinNew" },
    },
    { 'akinsho/git-conflict.nvim', version = "*", config = true }
}
lvim.colorscheme = "nord"

lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["q:"] = "<nop>"
lvim.keys.normal_mode["Q"] = "<nop>"
lvim.keys.normal_mode["<leader>ss"] = ":lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<CR>"


require('autocommands')
lvim.builtin.treesitter.indent = {
    disable = { "cpp" }
}

vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.tabstop = 4
vim.o.shiftwidth = 4
