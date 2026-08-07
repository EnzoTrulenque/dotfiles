return {
  "windwp/nvim-autopairs",
  event = { "VeryLazy" },
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")

    local Rule = require 'nvim-autopairs.rule'

    local cond = require 'nvim-autopairs.conds'

    local function has_unclosed_closing_char(char)
      local closing_char = char
      if char == '(' then closing_char = ')' end
      if char == '[' then closing_char = ']' end
      if char == '{' then closing_char = '}' end

      return function(opts)
        local line = opts.line
        local col = opts.col
        local line_suffix = line:sub(col)

        -- Encontra a primeira ocorrência do caractere de abertura ou fechamento
        local open_pos = line_suffix:find(char, 1, true)
        local close_pos = line_suffix:find(closing_char, 1, true)

        -- Se um caractere de fechamento existe E ele aparece antes de um de abertura
        -- (ou se não houver nenhum de abertura), então NÃO insira o par.
        if close_pos and (not open_pos or close_pos < open_pos) then
          return false
        end
        return true
      end
    end

    autopairs.setup({
      map_cr = true,
      check_ts = true,                      -- enable treesitter
      ts_config = {
        lua = { "string" },                 -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false,                       -- don't check treesitter on java
        c = false,
        cpp = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = true,
      disable_in_replace_mode = true,
      enable_moveright = true,
      ignored_next_char = "",
      enable_check_bracket_line = true, --- check bracket in same line
    })

    autopairs.add_rules({
      Rule("`", "'", "tex"),
      Rule("$", "$", "tex"),

      --[[
      Rule("(", ")"):with_pair(has_unclosed_closing_char('(')),
      Rule("[", "]"):with_pair(has_unclosed_closing_char('[')),
      Rule("{", "}"):with_pair(has_unclosed_closing_char('{')),

      Rule(' ', ' ')
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col, opts.col + 1)
          return vim.tbl_contains({ '$$', '()', '{}', '[]', '<>' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ '$  $', '(  )', '{  }', '[  ]', '<  >' }, context)
        end),
      ]] --
    })

    autopairs.get_rule('$'):with_move(function(opts)
      return opts.char == opts.next_char:sub(1, 1)
    end)

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- make autopairs and completion work together
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
