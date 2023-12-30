local keymap = vim.keymap.set

local telescope = require "telescope"
local telescopeConfig = require "telescope.config"

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
    layout_config = {
      prompt_position = "top",
    },
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { " " },
    },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
}

return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      -- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
      keymap(
        "i",
        "<C-g>",
        'copilot#Accept("<CR>")',
        { silent = true, expr = true, script = true, replace_keycodes = false }
      )
      keymap("i", "<C-j>", "<Plug>(copilot-next)")
      keymap("i", "<C-k>", "<Plug>(copilot-previous)")
      keymap("i", "<C-o>", "<Plug>(copilot-dismiss)")
      keymap("i", "<C-s>", "<Plug>(copilot-suggest)")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false, -- デフォルトで隠されているかどうか
          show_hidden_count = true,
          hide_dotfiles = false, -- dotfileを隠すかどうか
          hide_gitignored = false, -- gitignoreされているファイルを隠すかどうか
          hide_by_name = {
            "node_modules",
            "thumbs.db",
          },
          never_show = {
            ".git",
            ".DS_Store",
            ".history",
          },
        },
      },
    },
  },
  {
    "vim-skk/eskk.vim",
    config = function()
      vim.g["eskk#directory"] = "~/.cache/dein/repos/github.com/tyru/eskk.vim"
      vim.g["eskk#dictionary"] = { path = "~/.skk_jisyo", sorted = 1, encoding = "utf-8" }
      vim.g["eskk#large_dictionary"] = {
        path = "~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/SKK-JISYO.L",
        sorted = 1,
        encoding = "euc-jp",
      }
    end,
  },
  {
    "sbdchd/neoformat",
    -- disable = not plugin_status.neoformat,
    cmd = "Neoformat",
    setup = function()
      -- vim.g.neoformat_enabled_go = { "gofmt", "goimports" }
      -- require("core.mappings").neoformat()
    end,
  },
}
