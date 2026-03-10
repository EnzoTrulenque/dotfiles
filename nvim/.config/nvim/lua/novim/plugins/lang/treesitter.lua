return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- enable syntax highlighting
      highlight = {
        enable = true,
        disable = { "css", "latex", "markdown", "cls" }, -- list of language that will be disabled
        -- additional_vim_regex_highlighting = { 'org' }, -- for orgmode
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "html",
        "bash",
        "lua",
        "vim",
        "gitignore",
        "query",
        "python",
        "c",
        "cpp",
        "haskell",
        "gitignore",
        "bibtex",
        "vimdoc",
        -- "latex",
        -- "javascript",
        -- "typescript",
        -- "tsx",
        -- "css",
        -- "prisma",
        -- "markdown",
        -- "markdown_inline",
        -- "svelte",
        -- "graphql",
        -- "dockerfile",
        -- "perl",
      },
      auto_install = true,
      -- indent = { enable = false, disable = { "latex", "python", "css" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<C-p>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
      },
    })

    -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
    require("ts_context_commentstring").setup({})
  end,
}
