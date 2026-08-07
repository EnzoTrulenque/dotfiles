-- ==============================================================================
-- lua/novim/core/autocmds.lua
-- Eventos Automáticos
-- ==============================================================================

local api = vim.api
local keymap = vim.keymap.set

-- Cria um grupo central para garantir que os autocmds não sejam duplicados
local augroup = api.nvim_create_augroup("UserAutocmds", { clear = true })

-- ==============================================================================
-- 1. Melhorias de Qualidade de Vida (QoL)
-- ==============================================================================

-- Piscar o texto brevemente ao copiar (Yank Highlight)
api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Destacar texto ao copiar",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Restaurar o cursor na última posição conhecida ao abrir um arquivo
api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Restaurar cursor na última posição",
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remover espaços em branco no final das linhas ao salvar
api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  desc = "Remover trailing whitespace antes de salvar",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- ==============================================================================
-- 2. Configurações Específicas por Tipo de Arquivo / Buffer
-- ==============================================================================

-- Fechar buffers de informação flutuantes apenas apertando 'q'
api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "man", "help", "qf", "lspinfo", "checkhealth" },
  desc = "Fechar buffers de informação com 'q'",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    keymap("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Mapeamentos para o Terminal
api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  pattern = "term://*",
  desc = "Atalhos de navegação no terminal",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    -- <C-\><C-n> entra no modo normal do terminal sem matar o processo em execução
    keymap('t', '<esc>', [[<C-\><C-n>]], opts)
    keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end,
})

-- Mapeamentos para Markdown (Autolist)
api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown" },
  desc = "Atalhos e formatação para arquivos Markdown",
  callback = function(event)
    local opts = { buffer = event.buf, noremap = true, silent = true }

    keymap("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", opts)
    keymap("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
    keymap("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
    keymap("i", "<tab>", "<Esc>><cmd>AutolistRecalculate<cr>a<space>", opts)
    keymap("i", "<S-tab>", "<Esc><<cmd>AutolistRecalculate<cr>a", opts)
    keymap("n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
    keymap("v", "d", "d<cmd>AutolistRecalculate<cr>", opts)
    keymap("n", ">", "><cmd>AutolistRecalculate<cr>", opts)
    keymap("n", "<", "<<cmd>AutolistRecalculate<cr>", opts)
    keymap("n", "<C-c>", "<cmd>AutolistRecalculate<cr>", opts)

    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ==============================================================================
-- 3. Integrações Visuais
-- ==============================================================================

-- Toggle inteligente da Bufferline (Esconde no Alpha, mostra em todo o resto)
api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  desc = "Garante que a tabline só desapareça no Alpha",
  callback = function()
    -- Se o tipo do arquivo for 'alpha', esconde (0). Caso contrário, mostra sempre (2).
    if vim.bo.filetype == "alpha" then
      vim.opt.showtabline = 0
    else
      vim.opt.showtabline = 2
    end
  end,
})

-- Restaurar a Bufferline ao sair do Alpha
api.nvim_create_autocmd("BufUnload", {
  group = augroup,
  pattern = "*alpha", -- Asterisco garante que ele pegue qualquer variação do buffer alpha
  desc = "Restaurar tabline",
  callback = function()
    vim.opt.showtabline = 2
  end,
})
