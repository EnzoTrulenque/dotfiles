return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")
    local Rule = require('nvim-autopairs.rule')

    local function has_unclosed_closing_char(char)
      local closing_char = char
      if char == '(' then closing_char = ')' end
      if char == '[' then closing_char = ']' end
      if char == '{' then closing_char = '}' end

      return function(opts)
        local line = opts.line
        local col = opts.col
        local line_suffix = line:sub(col)
        local open_pos = line_suffix:find(char, 1, true)
        local close_pos = line_suffix:find(closing_char, 1, true)

        if close_pos and (not open_pos or close_pos < open_pos) then return false end
        return true
      end
    end

    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      enable_moveright = true,
      enable_check_bracket_line = true,
    })

    autopairs.add_rules({
      Rule("`", "'", "tex"),
      Rule("$", "$", "tex"),
      Rule("(", ")"):with_pair(has_unclosed_closing_char('(')),
      Rule("[", "]"):with_pair(has_unclosed_closing_char('[')),
      Rule("{", "}"):with_pair(has_unclosed_closing_char('{')),
    })

    autopairs.get_rule('$'):with_move(function(opts)
      return opts.char == opts.next_char:sub(1, 1)
    end)
  end,
}
