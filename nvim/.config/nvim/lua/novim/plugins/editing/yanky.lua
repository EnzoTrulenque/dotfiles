return {
  "gbprod/yanky.nvim",
  version = "*",
  -- Carrega quando o Yank for invocado ou ao ler um arquivo
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    -- P e p nativos agora são dominados pelo Yanky para preservar a posição
    { "p",     "<Plug>(YankyPutAfter)",                mode = { "n", "x" },                   desc = "Colar depois do cursor" },
    { "P",     "<Plug>(YankyPutBefore)",               mode = { "n", "x" },                   desc = "Colar antes do cursor" },
    { "gp",    "<Plug>(YankyGPutAfter)",               mode = { "n", "x" },                   desc = "Colar depois da seleção" },
    { "gP",    "<Plug>(YankyGPutBefore)",              mode = { "n", "x" },                   desc = "Colar antes da seleção" },
    -- Ciclar pelo histórico (após dar 'p')
    { "<c-p>", "<Plug>(YankyPreviousEntry)",           desc = "Colar anterior (Yanky)" },
    { "<c-n>", "<Plug>(YankyNextEntry)",               desc = "Colar próximo (Yanky)" },
    { "]p",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Colar com indentação (abaixo)" },
    { "[p",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Colar com indentação (acima)" },
  },
  config = function()
    require("telescope").load_extension("yank_history")

    require("yanky").setup({
      ring = { history_length = 100, storage = "shada", sync_with_numbered_registers = true },
      system_clipboard = { sync_with_ring = true },
      highlight = {
        on_put = true,
        -- Desligado porque o nosso core/autocmds.lua já faz isso de forma nativa e melhor
        on_yank = false,
        timer = 200,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    })
  end,
}
