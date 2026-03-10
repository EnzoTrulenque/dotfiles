return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.nvim" },
  config = function()
    local which_key = require("which-key")

    which_key.setup({
      show_help = false,
      show_keys = false,        -- show the currently pressed key and its label as a message in the command line
      notify = false,           -- prevent which-key from automatically setting up fields for defined mappings
      triggers = {
        { "<leader>", mode = { "n", "v" } },
      },
      plugins = {
        presets = {
          marks = false,        -- shows a list of your marks on ' and `
          registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false,    -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 10,   -- how many suggestions should be shown in the list?
          },
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false,      -- default bindings on <c-w>
          nav = false,          -- misc bindings to work with windows
          z = false,            -- bindings for folds, spelling and others prefixed with z
          g = false,            -- bindings for prefixed with g
        },
      },
      win = {
        no_overlap = true,
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        border = "rounded", -- can be 'none', 'single', 'double', 'shadow', etc.
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "left",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      layout = {
        spacing = 3,
        align = "left",
      },
      disable = {
        bt = { "help", "quickfix", "terminal", "prompt" },
        ft = { "NvimTree" },
      },
      layout = {
        width = { min = 20, max = 50 },                                             -- min and max width of the columns
        height = { min = 4, max = 25 },                                             -- min and max height of the columns
        spacing = 3,                                                                -- spacing between columns
        align = "left",                                                             -- align columns left, center or right
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
      },
      sort = { "local", "order", "group", "alphanum", "mod" },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        bt = { "help", "quickfix", "terminal", "prompt" }, -- for example
        ft = { "NvimTree" } -- add your explorer's filetype here
      },
    })

    -- 2. Carrega e registra todos os seus atalhos do arquivo separado
    require("novim.keymaps").register()
  end,
}
