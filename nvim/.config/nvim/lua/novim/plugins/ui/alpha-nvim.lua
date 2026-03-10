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

    -- Set color
    dashboard.section.header.opts.hl = "Title" -- lookup other hl groups with :highlight

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("s", "  Sessions", "<cmd>SessionManager load_session<CR>"),
      dashboard.button("r", "󰈚  Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("e", "󰱼  Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("f", "󰍉  Find", ":Telescope find_files <CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
      -- dashboard.button("i", "  Info", "<cmd>e ~/.config/CheatSheet.md<cr>"),
      dashboard.button("t", "󰥪  ToDo", "<cmd>vsplit ~/Documents/ToDo/quick.md<cr>"),
      dashboard.button("p", "  Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("h", "  Checkhealth", "<cmd>checkhealth<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa!<CR>"),
    }

    -- Set footer
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

    local plugins = "  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    local version = "    v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

    dashboard.section.footer.val = { plugins, version }
    dashboard.section.footer.opts.hl = "Comment"

    -- Send config to alpha
    alpha.setup(dashboard.opts)


    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        local plugins = "  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local version = "    v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

        -- TODO: Add random quote

        local footer = plugins .. "\t" .. version
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "disable tabline for alpha",
      callback = function()
        vim.opt.showtabline = 0
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      desc = "enable tabline after alpha",
      callback = function()
        vim.opt.showtabline = 2
      end,
    })
  end,
}
