local M = {}

function M.SearchWordUnderCursor()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').live_grep({ default_text = word })
end

function M.CloseBuffer()
  local current = vim.api.nvim_get_current_buf()
  vim.cmd('bdelete')  -- Close the current buffer

  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_set_current_buf(buf)
      break
    end
  end
end

function M.add_semicolon_at_end()
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Salva a posição [linha, coluna]
  vim.cmd("normal! A;") -- Adiciona o ';' no final
  vim.api.nvim_win_set_cursor(0, cursor_pos) -- Restaura a posição
end

function M.move_line_down() vim.cmd("m .+1") end

function M.move_line_up() vim.cmd("m .-2") end

function M.telescope_spell_suggest()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
    previewer = false,
    layout_config = { width = 50, height = 15 },
  }))
end

return M
