return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "SmiteshP/nvim-navic",
  },
  config = function()
    local lualine = require("lualine")

    local navic_component = {
      function()
        return require("nvim-navic").get_location()
      end,
      cond = function()
        return require("nvim-navic").is_available()
      end
    }

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { "NvimTree", "alpha" },
          winbar = { "NvimTree", "alpha" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = { {'filename', path = 1} },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {'filename', path = 1} },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {
        lualine_c = { navic_component },
      },
      inactive_winbar = {
        lualine_c = { navic_component },
      },
      extensions = {}
    })
  end,
}

