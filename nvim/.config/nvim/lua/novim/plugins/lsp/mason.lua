return {
  -- 1. mason.nvim (O Gerenciador de Ferramentas)
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2. mason-lspconfig.nvim (A Ponte entre Mason e lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- =====================================================================
      -- Configuração Visual de Diagnósticos (Ícones)
      -- Migrado do antigo core/diagnostics.lua
      -- =====================================================================
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰠠",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      })

      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Garante que o nvim-cmp envie as capacidades corretas para o LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",
          "lua_ls",
          "clangd",
          "html",
          "cssls",
          "tailwindcss",
        },

        handlers = {
          -- 1. Handler Padrão (Default)
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- 2. Handler Específico para Lua (lua_ls)
          -- Como usamos o 'lazydev.nvim', deixamos a configuração básica aqui,
          -- e o próprio lazydev se encarrega de injetar as globais e bibliotecas do Neovim.
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
            })
          end,

          -- 3. Handler Específico para Python (pyright)
          ["pyright"] = function()
            local util = require("lspconfig/util")
            local path = util.path

            lspconfig.pyright.setup({
              capabilities = capabilities,
              on_init = function(client)
                local venv_path = path.join(client.workspace_folders[1].name, ".venv", "bin", "python")
                if path.exists(venv_path) then
                  client.config.settings.python.pythonPath = venv_path
                  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
              end,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
