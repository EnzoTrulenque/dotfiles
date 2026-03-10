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
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      
      -- Garante que o nvim-cmp envie as capacidades corretas para o LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        -- Lista de servidores que serão instalados automaticamente
        ensure_installed = {
          "pyright",
          "lua_ls",
          "clangd",
          "html",
          "cssls",
          "tailwindcss",
        },

        -- AQUI ESTÁ A CORREÇÃO PRINCIPAL:
        -- Os handlers agora ficam DENTRO do setup, não fora.
        handlers = {
          -- 1. Handler Padrão (Default):
          -- Aplica-se a qualquer servidor que não tenha uma configuração específica abaixo.
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- 2. Handler Específico para Lua (lua_ls):
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            })
          end,
          ["pyright"] = function()
            local util = require("lspconfig/util")
            local path = util.path

            lspconfig.pyright.setup({
              capabilities = capabilities,
              -- Tenta encontrar a venv subindo as pastas até achar a raiz do projeto
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
                    diagnosticMode = "workspace", -- Muda de openFilesOnly para workspace
                  },
                },
              },
            })
          end,
          -- Adicione outros handlers específicos aqui se precisar (ex: ["rust_analyzer"] = ...)
        },
      })
    end,
  },
}
