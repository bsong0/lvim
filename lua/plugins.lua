lvim.plugins = {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      require("luasnip").config.set_config({ -- Setting LuaSnip config

        -- Enable autotriggered snippets
        enable_autosnippets = true,

        -- Use Tab (or some other key if you prefer) to trigger visual selection
        store_selection_keys = "<Tab>",
      })
      vim.cmd([[
            " press <Tab> to expand or jump in a snippet. These can also be mapped separately
            " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
            imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
            " -1 for jumping backwards.
            inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

            snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
            snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

            " For changing choices in choiceNodes (not strictly necessary for a basic setup).
            imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            ]])
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/lvim/luasnippets/" })
      local list_snips = function()
        local ft_list = require("luasnip").available()[vim.o.filetype]
        local ft_snips = {}
        for _, item in pairs(ft_list) do
          ft_snips[item.trigger] = item.name
        end
        print(vim.inspect(ft_snips))
      end

      vim.api.nvim_create_user_command("SnipList", list_snips, {})
    end
  },
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
  { "junegunn/seoul256.vim" },
  {
    "lervag/vimtex",
    ft = "tex"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        symbol_in_winbar = {
          enable = false
        },
        ui = {
          code_action = ''
        },
        lightbulb = {
          virtual_text = false
        }
      }
    end,
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons'      -- optional
    }
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup({
        draw = {
          animation = require('mini.indentscope').gen_animation.none()
        },
        mappings = {
          object_scope = '',
          object_scope_with_border = '',

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '',
          goto_bottom = '',
        }
      })
    end
  },
  {
    'stevearc/stickybuf.nvim',
    config = function()
      require("stickybuf").setup({
        -- This function is run on BufEnter to determine pinning should be activated
        get_auto_pin = function(bufnr)
          -- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned
          -- The function below encompasses the default logic. Inspect the source to see what it does.
          return require("stickybuf").should_auto_pin(bufnr)
        end
      })
    end
  },
  { "p00f/clangd_extensions.nvim" },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = 'markdown',
    config = true, -- or `opts = {}`
  }
}
