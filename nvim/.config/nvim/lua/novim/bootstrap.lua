-- BOOTSTRAP LAZY

-- Ensure Lazy is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Require all plugins
require("lazy").setup({
  { import = "novim.plugins.ai" },
  { import = "novim.plugins.completion" },
  { import = "novim.plugins.editing" },
  { import = "novim.plugins.git" },
  { import = "novim.plugins.lang" },
  { import = "novim.plugins.lsp" },
  { import = "novim.plugins.tools" },
  { import = "novim.plugins.ui" },
},
{
  install = {
    colorscheme = { "nightfox" },
  },
  -- Deactivate unecessary notifications
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
