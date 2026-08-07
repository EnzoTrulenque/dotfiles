return {
  "lervag/vimtex",
  init = function()
    -- Viewer settings
    vim.g.vimtex_view_method = 'zathura_simple' -- For Wayland compatibility, avoid xdotool
    vim.g.vimtex_view_forward_search_on_start = false
    vim.g.vimtex_context_pdf_viewer = 'okular'  -- External PDF viewer for the Vimtex menu

    -- Indentation settings
    vim.g.vimtex_indent_enabled = false -- Disable auto-indent from Vimtex
    vim.g.tex_indent_items = false      -- Disable indent for enumerate
    vim.g.tex_indent_brace = false      -- Disable brace indent

    -- Suppression settings
    vim.g.vimtex_quickfix_mode = 0 -- Suppress quickfix on save/build
    vim.g.vimtex_log_ignore = {    -- Suppress specific log messages
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }

    -- Other settings
    vim.g.vimtex_mappings_enabled = false -- Disable default mappings
    vim.g.tex_flavor = 'latex'            -- Set file type for TeX files
    vim.o.conceallevel = 2                -- Ativa  o nível de ocultação
    vim.g.tex_conceal = 'abdmg'           -- Configurações de ocultação para o LaTeX
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = vim.fn.expand("~") .. "/.texfiles/",
      out_dir = vim.fn.expand("~") .. "/.texfiles/",
    }
  end,
}
