return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- O Ruff organiza os imports (isort) e formata o código (black)
        python = { "ruff_organize_imports", "ruff_format" },
        -- Outras linguagens que você usa no ICMC
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      -- Configuração do Format on Save
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })

    --[[
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Formatar arquivo ou seleção (Mestre Python)" })
    --]]
  end,
}
