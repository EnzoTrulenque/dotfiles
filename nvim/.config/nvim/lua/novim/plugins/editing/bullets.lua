return {
  "bullets-vim/bullets.vim",
  ft = { "markdown", "text", "gitcommit" },
  config = function()
    require("bullets").setup({
      conceal = {
        enabled = true,
      },
    })
  end,
}
