return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "thick",
        close_command = function(buf_id)
          require("mini.bufremove").delete(buf_id, false)
        end,
        right_mouse_command = function(buf_id)
          require("mini.bufremove").delete(buf_id, false)
        end,
        diagnostics = true,           -- OR: | "nvim_lsp" 
        diagnostics_update_in_insert = true,
        show_tab_indicators = false,
        show_close_icon = true,
        -- numbers = "ordinal", -- Display buffer numbers as ordinal numbers
        sort_by = 'insert_after_current',
        offsets = {
          {
            filetype = "NvimTree",
            -- text = "Explorer",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            separator = "", -- use a "true" to enable the default, or set your own character
            -- padding = 1
          }
        },
        hover = {
          enabled = true,
          delay = 30,
          reveal = { 'close' }
        },
      },
    })
  end,
}
