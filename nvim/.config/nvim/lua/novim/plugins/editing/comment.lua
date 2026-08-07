return {
  -- 1. Configuramos o Contexto GLOBALMENTE e ensinamos o formato do C/C++
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
      languages = {
        -- Forçamos o comportamento de linha a ser o padrão
        c = { __default = "// %s", __multiline = "/* %s */" },
        cpp = { __default = "// %s", __multiline = "/* %s */" },
      },
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

      ---@diagnostic disable-next-line: missing-fields
      comment.setup({
        padding = true,
        sticky = true,
        pre_hook = ts_context_commentstring.create_pre_hook(),
        mappings = {
          basic = false,
          extra = false,
        },
      })
    end,
  },
}
