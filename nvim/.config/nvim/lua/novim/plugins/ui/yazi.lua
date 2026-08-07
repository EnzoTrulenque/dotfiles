return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    -- Se for 'true', o Yazi substitui o netrw e abre automaticamente
    -- quando você digita `nvim .` no terminal ou abre um diretório.
    open_for_directories = false,

    keymaps = {
      show_help = '<f1>',
    },
  },
}
