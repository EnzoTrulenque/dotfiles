return {
  -- 1) Plugin principal do Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
          }
        },
        panel = { enabled = false },
      })

      -- Toggle Copilot
      local enabled = true

      vim.keymap.set("i", "<C-h>", function()
        local suggestion = require("copilot.suggestion")

        if enabled then
          suggestion.dismiss()
          vim.b.copilot_suggestion_auto_trigger = false
          vim.g.copilot_suggestion_auto_trigger = false
          vim.notify("Copilot: disabled", vim.log.levels.INFO)
          enabled = false
        else
          vim.b.copilot_suggestion_auto_trigger = true
          vim.g.copilot_suggestion_auto_trigger = true
          vim.notify("Copilot: enabled", vim.log.levels.INFO)
          enabled = true
        end
      end, { desc = "Toggle Copilot" })
    end,
  },
}
