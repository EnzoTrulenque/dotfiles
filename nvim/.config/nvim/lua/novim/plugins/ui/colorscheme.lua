return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          style = "carbonfox",
          transparent = true,
          terminal_colors = true,
          dim_inactive = {
            enabled = false,
          },
          styles = {
            comments = "italic",
            keywords = "bold",
          },
        },
        groups = {
          all = {
            NormalNC = { bg = "NONE" },
            NvimTreeNormal = { bg = "NONE" },
            NvimTreeNormalNC = { bg = "NONE" },
            WinSeparator = { fg = "#3e4452", bg = "NONE" }, -- Deixa a linha de split transparente
          }
        },
      })

      vim.cmd("colorscheme nightfox")
    end,
  },
}
