return {
  "gbprod/yanky.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    -- Abre o histórico no Telescope
    {
      "<leader>fy", -- "find yank"
      "<cmd>Telescope yanky_history<cr>",
      desc = "Histórico de Yank (Yanky)",
    },
    -- Cicla pelo histórico para colar itens anteriores/posteriores
    { "[p", "<Plug>(YankyCyclePrev)" },
    { "]p", "<Plug>(YankyCycleNext)" },
  },
  
  -- Sua excelente configuração de 'opts' permanece a mesma
  opts = {
    ring = {
      history_length = 100,
      storage = "shada",
      sync_with_numbered_registers = true,
      cancel_event = "update",
      ignore_registers = { "_" },
      update_register_on_cycle = false,
    },
    picker = {
      telescope = {
        use_default_mappings = true,
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 150,
    },
    preserve_cursor_position = {
      enabled = true,
    },
    textobj = {
      enabled = true,
    },
  },
}
