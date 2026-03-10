return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Abrir DiffView" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Histórico do arquivo atual" },
  },
  opts = {},
}
