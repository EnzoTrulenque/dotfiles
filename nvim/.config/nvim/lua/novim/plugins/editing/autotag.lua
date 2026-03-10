return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        -- Aqui você pode customizar se quiser
        enable_close = true,          -- Fecha as tags automaticamente: <div> -> <div></div>
        enable_rename = true,         -- Renomeia a tag de fechamento junto com a de abertura
        enable_close_on_slash = false -- Fecha ao digitar /
      },
      -- Se quiser habilitar em arquivos específicos (além de HTML/XML)
      -- per_filetype = {
      --   ["typescriptreact"] = { enable_close = true }
      -- }
    })
  end,
}
