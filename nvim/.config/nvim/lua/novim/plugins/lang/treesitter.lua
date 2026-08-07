return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  branch = "main",
  dependencies = {
    -- IMPORTANTE: A dependência do textobjects obrigatoriamente deve seguir a branch main também
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- 1. Instalação das árvores sintáticas (Substitui o bloco 'ensure_installed')
    local parsers = {
      "json", "yaml", "html", "bash", "lua", "vim", "gitignore",
      "query", "python", "c", "cpp", "haskell", "bibtex", "vimdoc",
      "latex", "markdown", "markdown_inline"
    }

    -- Tenta instalar os parsers assincronamente ao carregar
    pcall(function()
      require("nvim-treesitter").install(parsers)
    end)

    -- 2. Ativação do Highlight e Indentação Nativa do Neovim
    -- Substitui os antigos blocos highlight = { enable = true } e indent = { enable = true }
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- Ativa o syntax highlight no buffer atual usando a API interna do editor
        pcall(vim.treesitter.start, args.buf)

        -- Ativa a indentação baseada na árvore de sintaxe atual do buffer
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- 3. Configuração de plugins externos
    require("ts_context_commentstring").setup({})

    -- NOTA: O módulo de textobjects agora gerencia a própria configuração independentemente.
    -- O módulo nativo de 'incremental_selection' foi removido e não deve ser declarado aqui.
  end,
}
