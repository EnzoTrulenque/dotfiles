return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      -- Desliga as sugestões nativas. O copilot-cmp fará todo o trabalho no menu.
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
