return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "f3fora/cmp-spell",
    "zbirenbaum/copilot-cmp",
    "quangnguyen30192/cmp-nvim-ultisnips",
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    vim.opt.spell = true
    vim.opt.spelllang = { "pt", "en" }

    opts.snippet = opts.snippet or {}
    opts.snippet.expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end

    opts.sources = opts.sources or {}
    table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
    table.insert(opts.sources, { name = "spell" })
    table.insert(opts.sources, { name = "nvim_lsp" })
    table.insert(opts.sources, { name = "ultisnips" })
    table.insert(opts.sources, { name = "buffer" })
    table.insert(opts.sources, { name = "path" })

    opts.completion = opts.completion or {}
    opts.completion.keyword_length = 2

    opts.mapping = opts.mapping or cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(UltiSnipsExpandTrigger)", true, true, true))
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(UltiSnipsJumpBackTrigger)", true, true, true))
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
