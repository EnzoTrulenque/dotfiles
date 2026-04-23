-- ==============================================================================
-- lua/novim/core/functions.lua
-- Funções Utilitárias Customizadas
-- ==============================================================================

local M = {}

--- Busca a palavra sob o cursor em todo o projeto usando o Telescope (live_grep).
function M.SearchWordUnderCursor()
  local word = vim.fn.expand('<cword>')
  require('telescope.builtin').live_grep({ default_text = word })
end

--- Fecha o buffer atual de forma segura, movendo para o anterior antes de deletá-lo.
function M.CloseBuffer()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('bprevious')
  vim.cmd('bdelete ' .. buf)
end

--- Adiciona um ponto e vírgula (;) no final da linha atual
--- sem alterar a posição original do cursor.
function M.add_semicolon_at_end()
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Salva a posição atual
  vim.cmd("normal! A;")                             -- Vai pro fim da linha e insere ';'
  vim.api.nvim_win_set_cursor(0, cursor_pos)        -- Restaura a posição
end

--- Move a linha atual uma posição para baixo.
function M.move_line_down()
  vim.cmd("m .+1")
end

--- Move a linha atual uma posição para cima.
function M.move_line_up()
  vim.cmd("m .-2")
end

--- Abre sugestões de ortografia do Telescope em uma janela flutuante
--- compacta, posicionada exatamente abaixo do cursor.
function M.telescope_spell_suggest()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
    previewer = false,
    layout_config = { width = 50, height = 15 },
  }))
end

return M
