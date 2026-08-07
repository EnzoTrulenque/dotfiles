return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  -- O plugin carrega apenas quando você abre um arquivo Markdown
  ft = { 'markdown', 'vimwiki' },
  config = function()
    require('render-markdown').setup({
      -- Você pode customizar os ícones dos checkboxes, bordas das tabelas, etc.
      heading = {
        sign = false,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      checkbox = {
        checked = { icon = '󰄲 ' },
        unchecked = { icon = '󰄱 ' },
      },
      render_modes = true,
    })
  end,
}
