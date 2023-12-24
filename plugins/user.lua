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

-- require("mason-nvim-dap").setup {
--   ensure_installed = { "delve", "go-debug-adapter" },
--   automatic_installation = true, -- 自動インストールを有効にする
--   handlers = {
--     delve = function(config) -- 'go'キーでGo言語のハンドラーを追加
--       -- DAPアダプター設定
--       config.adapters = {
--         type = "server", -- サーバータイプのアダプターを使用
--         host = "127.0.0.1", -- Delveサーバーのホストアドレス
--         port = 2345, -- Delveサーバーのポート
--       }
--
--       -- DAP設定
--       config.configurations = {
--         {
--           type = "delve",
--           name = "Attach to Process",
--           mode = "local",
--           request = "attach",
--           remotePath = "${workspaceFolder}", -- リモートのワークスペースパス
--           port = 2345, -- Delveサーバーのポート
--           host = "127.0.0.1", -- Delveサーバーのホストアドレス
--         },
--         {
--           type = "delve",
--           name = "Debug",
--           request = "launch",
--           program = "${file}", -- 現在のファイルをデバッグ
--         },
--         {
--           type = "delve",
--           name = "Debug test",
--           request = "launch",
--           mode = "test",
--           program = "${file}",
--         },
--       }

-- デフォルトの設定を適用
-- require("mason-nvim-dap").default_setup(config)
--     end,
--   },
-- }

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
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    -- setup = function() require "custom.configs.visual-multi" end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufReadPost",
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = "*",
        callback = function()
          -- comment
          require("mini.comment").setup {}
          -- splitjoin
          require("mini.splitjoin").setup {}
          -- surround
          require("mini.surround").setup {
            mappings = {
              add = "sa",
              delete = "sd",
              find = "sf",
              find_left = "sF",
              highlight = "sh",
              replace = "sc",
              update_n_lines = "sn",
              suffix_last = "l",
              suffix_next = "n",
            },
          }
        end,
        once = true,
      })

      -- hipatterns
      local hipatterns = require "mini.hipatterns"
      hipatterns.setup {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },

          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    lazy = false,
    config = function()
      keymap("n", "<Leader>gm", "<CMD>GitMessenger<CR>", { desc = "Show git blame on the current line" })
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {
        delve = function(config)
          local port = 2345
          config.adapters = {
            -- delve = {
            type = "server",
            host = "localhost",
            port = port,
            -- command = vim.fn.stdpath "data" .. "/mason/bin/dlv",
            -- args = { "dap", "-l", "127.0.0.1:" .. port },
            -- },
          }
          -- local dap = require "dap"
          -- dap.adapters.delve = {
          --   type = "server",
          -- port = "${port}",
          -- port = port,
          -- }
          config.configurations = vim.list_extend(config.configurations or {}, {
            {
              type = "delve",
              name = "Delve: Remote",
              mode = "remote",
              remotePath = "",
              request = "attach",
              host = "localhost",
              cwd = "${workspaceRoot}",
              port = port,
            },
          })
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
