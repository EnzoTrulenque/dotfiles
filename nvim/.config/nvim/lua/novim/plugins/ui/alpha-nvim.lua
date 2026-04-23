return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "Shatur/neovim-session-manager",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                               ",
      "                                                               ",
      "          ████ ██████   ██████  █████                      ",
      "         ███████████     ████   ███ ██                   ",
      "         █████████       ████  ███     ███  ██  ██ ",
      "        ██████████████ ████ ██████  ██████████████ ",
      "       █████████ █  ██ ███████ ██  ██  ██  ██  ",
      "     ████████████  ██ ███████ ██  ██  ██  ██   ",
      "    ██████  ███ ██████ ██████ ███ ███ ███ ███   ",
      "                                                               ",
    }

    dashboard.section.header.opts.hl = "Title"

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("s", "  Sessions", "<cmd>SessionManager load_session<CR>"),
      dashboard.button("r", "󰈚  Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("e", "󰱼  Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("f", "󰍉  Find", ":Telescope find_files <CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
      dashboard.button("t", "󰥪  ToDo", "<cmd>vsplit ~/Documents/ToDo/quick.md<cr>"),
      dashboard.button("p", "  Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("h", "  Checkhealth", "<cmd>checkhealth<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa!<CR>"),
    }

    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local plugins = "  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    local version = "    v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

    dashboard.section.footer.val = { plugins, version }
    dashboard.section.footer.opts.hl = "Comment"

    alpha.setup(dashboard.opts)
  end,
}
