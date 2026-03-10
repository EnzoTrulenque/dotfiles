return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatClose", "CopilotChatAsk", "CopilotChatToggle" },
    dependencies = {
      "zbirenbaum/copilot.lua",   -- Copilot core (já autenticado)
      "nvim-lua/plenary.nvim",    -- necessário para async, curl e logging
    },
    build = "make tiktoken",
    opts = {
      auto_insert_mode = true,
      question_header   = "  " .. (vim.env.USER or "User"),
      answer_header     = "  Copilot",
      window            = { width = 0.4 },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)  -- inicializa com as opções

      -- Cria o comando :CopilotChatToggle (embutido na API)
      vim.api.nvim_create_user_command("CopilotChatToggle", function()
        chat.toggle()
      end, {})

    end,
  },
}
