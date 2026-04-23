return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    -- 1. O MOTOR DO ULTISNIPS (Restaurado e configurado para não roubar atalhos)
    {
      "SirVer/ultisnips",
      dependencies = { "honza/vim-snippets" },
      init = function()
        -- Atribui atalhos "fictícios" para que o plugin não roube o <Tab> nativo do Neovim
        vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
        vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
      end
    },
    "quangnguyen30192/cmp-nvim-ultisnips", -- A ponte de integração

    "zbirenbaum/copilot-cmp",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    "f3fora/cmp-spell",
    "micangl/cmp-vimtex",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- 2. Importamos as funções seguras do UltiSnips direto para o Lua
    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    vim.opt.spell = true
    vim.opt.spelllang = { "pt", "en" }

    cmp.setup({
      completion = {
        completeopt = "menu,noselect",
      },
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
      mapping = {
        -- Enter: Só autocompleta SE você tiver selecionado uma opção ativamente.
        -- Caso contrário (mesmo com o menu aberto), ele apenas quebra a linha.
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
        }),

        -- Navegação: <C-n>/<C-p> ou as setas do teclado para mover E selecionar.
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        -- Rolagem da janela de documentação adjacente
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Fecha o menu de autocomplete rapidamente
        ["<C-e>"] = cmp.mapping.abort(),

        -- Tab Blindado: Única e exclusivamente para pular em snippets ou dar indentação.
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- A função nativa do cmp_ultisnips já lida com o fallback (inserir um tab real)
          -- caso não haja nenhum snippet para expandir ou pular.
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          cmp_ultisnips_mappings.jump_backwards(fallback)
        end, { "i", "s" }),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = ({
            ultisnips = "[Snippet]",
            nvim_lsp = "[LSP]",
            copilot = "[AI]",
            buffer = "[Buffer]",
            spell = "[Spell]",
            vimtex = "[VimTeX]",
            path = "[Path]",
          })
        })
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp",  priority = 1000 },
        { name = "copilot",   priority = 900 },
        { name = "ultisnips", priority = 800 },
        { name = "vimtex",    priority = 700 },
        { name = "buffer",    keyword_length = 3, priority = 500 },
        {
          name = "spell",
          keyword_length = 4,
          priority = 400,
          option = {
            keep_all_entries = false,
            enable_in_context = function() return true end
          },
        },
        { name = "path", priority = 300 },
      }),
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      view = {
        entries = 'custom',
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      performance = {
        trigger_debounce_time = 150,
        throttle = 150,
        fetching_timeout = 200,
      },
    })

    -- Busca (/)
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } }
    })

    -- Comandos (:)
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'path' }, { name = 'cmdline' } }
    })
  end,
}
