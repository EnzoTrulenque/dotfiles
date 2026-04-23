return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        haskell = { "fourmolu" }, -- Formatação padrão ouro para Haskell
        asm = { "asmfmt" },       -- Formatação para Assembly RISC-V/x86
        json = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000, -- Aumentado levemente para evitar timeout em C++ muito grande
      },
    })
  end,
}
