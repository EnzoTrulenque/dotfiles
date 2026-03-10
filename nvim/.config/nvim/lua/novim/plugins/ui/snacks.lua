return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({
      bigfile      = { enabled = true },
      cursor       = { enabled = true },
      dashboard    = { enabled = false },
      explorer     = { enabled = true },
      iguide       = { enabled = true },
      indent       = { enabled = false },
      input        = { enabled = false },
      matcher      = { enabled = true },
      picker       = { enabled = false },
      quickfile    = { enabled = true },
      scope        = { enabled = true },
      scroll       = { enabled = true },
      search       = { enabled = true },
      statuscolumn = { enabled = true },
      win          = { enabled = true },
      words        = { enabled = true },
    })
  end,
}
