-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command    -- vim-visual-multi
    -- ["<A-k>"] = { "<cmd>call vm#commands#add_cursor_up(0, v:count1)<CR>" },

    -- git diff vieww
    ["gdo"] = { "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    ["gdc"] = { "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
    ["gdf"] = { "<cmd>DiffviewFileHistory<CR>", desc = "Open DiffviewFileHistory" },

    -- git conflict
    ["gco"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Git Conflict Choose Ours" },
    ["gct"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Git Conflict Choose Theirs" },
    ["gcB"] = { "<cmd>GitConflictChooseBase<CR>", desc = "Git Conflict Choose Base" },
    ["gcb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Git Conflict Choose Both" },
    ["gcn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Git Conflict Choose None" },
    ["gcj"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Git Conflict Next Conflict" },
    ["gck"] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Git Conflict Prev Conflict" },
    ["gcq"] = { "<cmd>GitConflictListQf<CR>", desc = "Git Conflict List Qf" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<leader>f"] = {
      ":Neoformat<CR>",
      desc = "Format code with Neoformat",
    },
  },
}
