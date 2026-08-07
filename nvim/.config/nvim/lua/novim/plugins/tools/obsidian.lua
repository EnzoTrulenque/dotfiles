return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      -- Coloque aqui o caminho exato para a pasta do seu cofre do Obsidian
      workspaces = {
        {
          name = "meu_cofre",
          path = "~/Documentos/Obsidian Vault",
        },
      },
      -- Comportamento ao criar novas notas
      new_notes_location = "current_dir",

      -- UI nativa do plugin (podemos desativar algumas coisas para não brigar com o render-markdown)
      ui = { enable = false },
    })
  end,
}
