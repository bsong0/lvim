-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.api.nvim_set_option("clipboard", "unnamed")

lvim.plugins = {
  { "shaunsingh/nord.nvim" },
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
    "ggandor/leap.nvim",
    lazy=false,
    dependencies = {"tpope/vim-repeat"},
    config = function ()
      require('leap').add_default_mappings()
    end
  }
}
lvim.colorscheme = "nord"

lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"

if vim.g.neovide then
  vim.o.guifont = "ComicCode Nerd Font:h9"
end

require('autocommands')
