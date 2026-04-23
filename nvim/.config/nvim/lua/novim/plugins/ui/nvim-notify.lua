return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 1000, -- Corrigido: ortografia e convertido para número
  config = function()
    local notify = require("notify")

    notify.setup({
      stages = "fade",
      position = "top_right",
      timeout = 500,
      max_width = 50,
      max_height = 10,
      background_colour = "#1e222a",
      level = "INFO",
      render = "default",
    })

    vim.notify = notify
  end,
}
