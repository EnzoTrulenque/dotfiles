return {
  {
    "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    config = function()
      vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
    end
  },
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    dependencies = {'hrsh7th/nvim-cmp'}
  }
}

