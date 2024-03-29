-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        "tsserver",
        "cssls",
        "jsonls",
        "emmet_ls",
        "terraformls",
        "tailwindcss",
        "dockerls",
        "docker_compose_language_service",
        "bashls",
        "vuels",
        "vimls",
        "volar",
        "sqlls",
        "golangci_lint_ls",
        "gopls",
        "html",
        "yamlls",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "prettier",
        "stylua",
        "sqlfmt",
        "goimports",
        "gotest",
        "yamlfmt",
        "yamllint",
        "luaformatter",
        "marksman",
        "eslint_d",
        "eslint",
        "jsonlint",
        "markdownlint",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "delve",
      })
    end,
  },
}
