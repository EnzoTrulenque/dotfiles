local api = vim.api
local keymap = vim.keymap.set

-- Creates a group for all the custom autocmds
local augroup = api.nvim_create_augroup("UserAutocmds", { clear = true })

-- Associate each autocmd to the group

-- Close help, man, qf, lspinfo with 'q'
api.nvim_create_autocmd("FileType", {
  pattern = { "man", "help", "qf", "lspinfo" }, -- "startuptime",
  command = "nnoremap <buffer><silent> q :close<CR>",
  group = augroup,
})

-- Terminal mappings
local function set_terminal_keymaps()
  local opts = { buffer = 0 , silent = true}
  keymap('t', '<esc>', [[<C-c>]], opts)
  keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" }, -- use term://*toggleterm#* for only ToggleTerm
  callback = set_terminal_keymaps,
  group = augroup,
})

-- Autolist markdown mappings
local function set_markdown_keymaps()
  local opts = { buffer = true, noremap = true } -- Options for keymap.set
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
  -- keymap("n", "<C-n>", "<cmd>lua HandleCheckbox()<CR>", opts)
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end

api.nvim_create_autocmd("FileType", {
    pattern = { "*.md" },
    callback = set_markdown_keymaps,
  }
)

-- BOOT SCREEN

-- Hides the bufferline for Alpha boot screen
api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  desc = "disable tabline for alpha",
  callback = function()
    vim.opt.showtabline = 0
  end,
  group = augroup,
})

-- Enables bufferline upon exiting Alpha
api.nvim_create_autocmd("BufUnload", {
  pattern = "alpha",
  callback = function()
    vim.opt.showtabline = 2
  end,
  group = augroup,
})

-- Firenvim

-- vim.api.nvim_create_autocmd({'UIEnter'}, {
--     callback = function(event)
--         local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
--         if client ~= nil and client.name == "Firenvim" then
--             -- vim.o.laststatus = 0
--             cmd = "LspStop"
--         end
--     end
-- })

