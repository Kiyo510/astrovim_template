local M = {}
function M.setup()
  return {
    ensure_installed = {
      -- Lsp
      -- "clangd",
      -- "pyright",
      "lua-language-server",
      "typescript-language-server",
      "vim-language-server",
      "html-lsp",
      "css-lsp",
      "json-lsp",
      "emmet-ls",
      "terraform-ls",

      -- Formatter
      "prettierd",

      -- "prettier",
      "stylua",
      "black",
      "yamlfmt",
      "marksman",

      -- Linter
      "eslint_d",
      -- "eslint-lsp",

      -- Diagnostics
      -- "cspell",

      -- Dap
      -- "debugpy",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
  }
end

return M
