local opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = " "

local custom_functions = require("novim.core.functions")

-------------------- General Keymaps --------------------

-- delete without copying into register
-- map("n", "x", '"_x', opts)
-- map("v", "p", '"_dP', opts)

-- Unmappings
map("n", "<C-z>", "<nop>", opts)
map("n", "gc", "<nop>", opts)
map("n", "gcc", "<nop>", opts)

-- Terminal
map("n", "<C-t>", "<cmd>Floaterminal<CR>", opts)

-- Spelling
map("n", "<C-s>", custom_functions.telescope_spell_suggest, opts)

-- Kill search highlights
map("n", "<CR>", "<cmd>noh<CR>", opts)

-- Find project files
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)

-- Toggle comments
map('n', "<C-/>", '<Plug>(comment_toggle_linewise_current)', opts)
map('x', "<C-/>", '<Plug>(comment_toggle_linewise_visual)', opts)

-- Open help on word
map("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts)

-- Fix 'Y', 'E'
map("n", "Y", "y$", opts)
map("n", "E", "ge", opts)
map("v", "Y", "y$", opts)
map("v", "E", "ge", opts)

-- Center cursor
map("n", "m", "zt", opts)
map("v", "m", "zt", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize-2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<A-Left>", ":vertical resize -2<CR>", opts)
map("n", "<A-Right>", ":vertical resize +2<CR>", opts)
map("n", "<A-h>", ":vertical resize -2<CR>", opts)
map("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<TAB>", ":bnext<CR>", opts)
map("n", "<S-TAB>", ":bprevious<CR>", opts)
map("n", "<BS>", ":BufferLineMoveNext<CR>", opts)
map("n", "<S-BS>", ":BufferLineMovePrev<CR>", opts)

-- Drag lines
map("n", "<A-j>", custom_functions.move_line_down, opts)
map("n", "<A-k>", custom_functions.move_line_up, opts)

map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
map("v", "<A-j>", ":m'>+<CR>gv", opts)
map("v", "<A-k>", ":m-2<CR>gv", opts)

-- Vertical line movements --
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)

-- Horizontal line movements --
map("v", "<S-h>", "g^", opts)
map("v", "<S-l>", "g$", opts)
map("n", "<S-h>", "g^", opts)
map("n", "<S-l>", "g$", opts)

-- Indentation
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<", "<<", opts)
map("n", ">", ">>", opts)

-- Navigate display lines
map("n", "J", "gj", opts)
map("n", "K", "gk", opts)
map("v", "J", "gj", opts)
map("v", "K", "gk", opts)

-- Long line travel
-- map("n", "<C-j>", "30j", opts)
-- map("n", "<C-k>", "30k", opts)
-- map("v", "<C-j>", "30j", opts)
-- map("v", "<C-k>", "30k", opts)

-- Inserts ';' at the end of the line
map("n", "<C-;>", custom_functions.add_semicolon_at_end, opts)
