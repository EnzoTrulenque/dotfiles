return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter", -- Carrega apenas quando você começa a digitar
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = false, -- Começa DESATIVADO
        keymap = {
          -- Aceita a sugestão com Ctrl+L (não rouba o seu Tab de indentação)
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
        }
      },
      panel = { enabled = false },
    })
  end,
}
