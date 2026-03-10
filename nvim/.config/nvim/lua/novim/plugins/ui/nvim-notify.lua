return {
  "rcarriga/nvim-notify",
  lazy = false,
  priotirity = "1000",
  config = function()
    local notify = require("notify")

    notify.setup({
      -- Animação das notificações
      -- Opções: 'fade', 'slide', 'fade_in_slide_out', 'static'
      stages = "fade",

      -- Posição na tela (padrão: 'bottom_right')
      -- 'top_left', 'top_mid', 'top_right', 'bottom_left', 'bottom_mid', 'bottom_right'
      position = "top_right",

      -- Tempo em milissegundos para a notificação desaparecer (3 segundos)
      timeout = 500,

      max_width = 50,
      max_height = 10,

      -- Cor de fundo para as notificações
      background_colour = "#1e222a", -- Um cinza escuro para se destacar sutilmente

      -- Nível mínimo de mensagem para exibir (ex: 'INFO', 'WARN', 'ERROR')
      -- 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR'
      level = "INFO",

      -- Renderização de ícones e markdown
      render = "default",
    })

    -- [[ IMPORTANTE ]]
    -- Esta linha substitui a função de notificação padrão do Neovim
    -- pela do nvim-notify. É o que faz o plugin funcionar.
    vim.notify = notify
  end,
}
