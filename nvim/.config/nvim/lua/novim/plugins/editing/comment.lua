return {
  -- 1. Configuramos o Contexto GLOBALMENTE e IMEDIATAMENTE
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false, -- Mata o erro no CursorHold logo no boot
    },
    config = function(_, opts)
      require('ts_context_commentstring').setup(opts)
    end,
  },

  -- 2. O Comment.nvim continua carregando só quando você abrir um arquivo
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      comment.setup({
        padding = true,
        sticky = true,
        ignore = nil,
        pre_hook = ts_context_commentstring.create_pre_hook(),
        mappings = {
          basic = false,
          extra = false,
        },
      })
    end,
  },
}
