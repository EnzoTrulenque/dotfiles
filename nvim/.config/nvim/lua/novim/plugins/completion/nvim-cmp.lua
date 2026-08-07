return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    -- 1. O MOTOR DO ULTISNIPS (De volta às raízes)
    {
      "SirVer/ultisnips",
      dependencies = { "honza/vim-snippets" },
      init = function()
        vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        vim.g.UltiSnipsJumpForwardTrigger = "<C-l>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<C-h>"
      end
    },
    "quangnguyen30192/cmp-nvim-ultisnips",

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
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
          end
        end, { "i", "s" }),

        -- Navegação pelas setas ou C-j / C-k
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippet()<CR>", true, true, true), "m", true)
          else
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
          end
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

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } }
    })

    -- Capturamos o preset do cmdline para manter o Tab e o Enter funcionando
    local cmdline_mapping = cmp.mapping.preset.cmdline()

    -- Injetamos a navegação com C-j e C-k no contexto de comando (c)
    cmdline_mapping['<C-j>'] = { c = cmp.mapping.select_next_item() }
    cmdline_mapping['<C-k>'] = { c = cmp.mapping.select_prev_item() }

    cmp.setup.cmdline(':', {
      mapping = cmdline_mapping,
      sources = { { name = 'path' }, { name = 'cmdline' } }
    })
  end,
}
