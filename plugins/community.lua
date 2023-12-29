return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.colorscheme.gruvbox-baby" },
  { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  {
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = {
        options = {
          theme = "gruvbox_dark",
        },
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
        },
      },
    },
    -- {
    --   "rebelot/heirline.nvim",
    --   optional = true,
    --   opts = function(_, opts) opts.statusline = nil end,
    -- },
  },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
