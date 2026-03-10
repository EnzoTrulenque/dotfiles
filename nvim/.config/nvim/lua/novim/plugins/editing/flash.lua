return {
  "folke/flash.nvim",
  event = "VeryLazy",
  -- O plugin funciona muito bem com as configurações padrão,
  -- então uma tabela de 'opts' vazia é geralmente suficiente.
  opts = {},
  --[[
    -- Opcional: Para desativar o sombreamento de fundo e usar apenas as etiquetas
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyz",
      label = {
        rainbow = {
          enabled = true,
        },
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          label_case = "lowercase",
        },
      },
    },
  --]]

  -- 'keys' é a melhor forma de configurar os atalhos deste plugin
  keys = {
    -- Salto padrão. Pressione 's' e depois um caractere para pular.
    {
      "z",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
    -- Salto inteligente com Treesitter (pula para nós de código).
    {
      "Z",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    -- Salto entre janelas (splits).
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Flash Remote",
    },
    -- Busca com Treesitter entre janelas.
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
    },
  },
}
