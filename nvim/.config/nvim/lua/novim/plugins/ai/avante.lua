return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  -- O build 'make' é essencial para compilar as bibliotecas no Linux
  build = "make",
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",

    providers = {
      copilot = {
        endpoint = "https://api.github.com/copilot_internal/v2/sampling",
        model = "gpt-4o-2024-05-13", -- Modelo de elite do Copilot
        proxy = nil,
        allow_insecure_server_cipher = false,
      },
    },

    behaviour = {
      auto_suggestions = false, -- Deixe o Copilot lidar com isso via Ghost Text
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
  },
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
