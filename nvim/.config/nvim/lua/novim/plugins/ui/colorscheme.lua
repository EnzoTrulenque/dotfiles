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
            shade = "dark",
            percentage = 0.15,
          },
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "NONE",
            variables = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            lualine = true,
            treesitter = true,
            notify = true,
            mini = true,
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      vim.cmd("colorscheme nightfox")
    end,
  },
}
