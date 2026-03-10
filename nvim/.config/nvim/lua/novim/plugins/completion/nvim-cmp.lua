return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",                  -- source for text in buffer
    "hrsh7th/cmp-path",                    -- source for file system paths
    "quangnguyen30192/cmp-nvim-ultisnips", -- UltiSnips
    -- "rafamadriz/friendly-snippets", -- useful snippets
    "zbirenbaum/copilot-cmp",              -- source for GitHub Copilot
    "onsails/lspkind.nvim",                -- vs-code like pictograms
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    "f3fora/cmp-spell",
    "micangl/cmp-vimtex",
    -- "aspeddro/cmp-pandoc.nvim",
    -- Large language model
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.setup({
      completion = {
        completeopt = "menu,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      },
      -- formatting for autocompletion
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
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "copilot" },
        { name = "ultisnips" },
        { name = "vimtex" },
        -- { name = "orgmode" },
        -- { name = "pandoc" },
        -- { name = "omni" },
        { name = "buffer",   keyword_length = 3 }, -- text within current buffer
        {
          name = "spell",
          keyword_length = 4,
          option = {
            keep_all_entries = false,
            enable_in_context = function()
              return true
            end
          },
        },
        { name = "path" },
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
      init = function()
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
      end
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'path' },
        { name = 'cmdline' }
      }
    })
  end,
}
