return {
  "folke/lazydev.nvim",
  ft = "lua", -- Only loads in .lua files
  opts = {
    library = {
      -- Adiciona definições de tipos para o loop de eventos (uv)
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
  dependencies = { "Bilal2453/luvit-meta", lazy = true },
}
