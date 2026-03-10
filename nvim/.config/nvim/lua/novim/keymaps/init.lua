local M = {}

function M.register()
  local wk = require("which-key")

  local mappings = {
    -- Atalhos de Nível Superior
    { "<leader>d", "<cmd>update! | bdelete!<CR>", desc = "Delete buffer", icon = "" },
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer", icon = "󰥩" },
    { "<leader>h", "<cmd>Alpha<CR>", desc = "Home", icon = "" },
    { "<leader>i", "<cmd>VimtexTocOpen<CR>", desc = "Index" },
    { "<leader>q", "<cmd>wa! | qa!<CR>", desc = "Quit", icon = "󰈆" },
    { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo history", icon = "" },
    { "<leader>v", "<cmd>VimtexView<CR>", desc = "View" },
    { "<leader>w", "<cmd>w!<CR>", desc = "Write", icon = "" },
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen", icon = "󱅻" },

    { "<leader>a", group = "Ai", icon = "" },
    { "<leader>ai", "<cmd>Copilot toggle<CR>", desc = "Copilot inline", icons = "" }, -- Activates
    { "<leader>aC", "<cmd>CopilotChatToggle<CR>", desc = "Copilot Chat", icon = "" },

    { "<leader>f", group = "Find", icon = "" },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", desc = "buffers" },
    { "<leader>fc", "<cmd>Telescope bibtex format_string=\\citet{%s}<CR>", desc = "citations" },
    { "<leader>ff", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "project", icons = "" },
    { "<leader>fg", "<cmd>Telescope git_commits<CR>", desc = "git history" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "keymaps" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "recent" },
    { "<leader>fr", "<cmd>Telescope registers<CR>", desc = "registers" },
    { "<leader>ft", "<cmd>Telescope colorscheme<CR>", desc = "theme" },
    { "<leader>fw", "<cmd>lua SearchWordUnderCursor()<CR>", desc = "word" },
    { "<leader>fy", "<cmd>YankyRingHistory<CR>", desc = "yanks" },

    { "<leader>g", group = "Git", icon = "󰊢" },
    { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "checkout branch" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "diff" },
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
    { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", desc = "next hunk" },
    { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", desc = "prev hunk" },
    { "<leader>gl", "<cmd>Gitsigns blame_line<CR>", desc = "line blame" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "preview hunk" },
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "toggle blame" },

    { "<leader>L", group = "List", icon = "󰦏" },
    { "<leader>Lc", "<cmd>lua HandleCheckbox()<CR>", desc = "checkbox" },
    { "<leader>Ln", "<cmd>AutolistCycleNext<CR>", desc = "next" },
    { "<leader>Lp", "<cmd>AutolistCyclePrev<CR>", desc = "previous" },
    { "<leader>Lr", "<cmd>AutolistRecalculate<CR>", desc = "reorder" },

    { "<leader>l", group = "LSP", icon = "󰬡" },
    { "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "buffer diagnostics" },
    { "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code action" },
    { "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", desc = "definition" },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "declaration" },
    { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "help" },
    { "<leader>li", "<cmd>Telescope lsp_implementations<CR>", desc = "implementations" },
    { "<leader>lk", "<cmd>LspStop<CR>", desc = "kill lsp" },
    { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "line diagnostics" },
    { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "next diagnostic" },
    { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "previous diagnostic" },
    { "<leader>lr", "<cmd>Telescope lsp_references<CR>", desc = "references" },
    { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename" },
    { "<leader>ls", "<cmd>LspRestart<CR>", desc = "restart lsp" },
    { "<leader>lt", "<cmd>LspStart<CR>", desc = "start lsp" },

    { "<leader>m", group = "Markdown", icon = "" },
    { "<leader>mv", "<cmd>Slides<CR>", desc = "view slides" },

    { "<leader>n", group = "NixOS", icon = "" },
    { "<leader>nd", "<cmd>TermExec cmd='nix develop'<CR><C-w>j", desc = "develop" },
    { "<leader>ng", "<cmd>TermExec cmd='nix-collect-garbage --delete-older-than 15d'<CR><C-w>j", desc = "garbage" },
    { "<leader>nh", "<cmd>TermExec cmd='home-manager switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "home-manager" },
    { "<leader>nm", "<cmd>TermExec cmd='brave https://mynixos.com' open=0<CR>", desc = "my-nixos" },
    { "<leader>np", "<cmd>TermExec cmd='brave https://search.nixos.org/packages' open=0<CR>", desc = "packages" },
    { "<leader>nr", "<cmd>TermExec cmd='sudo nixos-rebuild switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "rebuild flake" },
    { "<leader>nu", "<cmd>TermExec cmd='nix flake update'<CR><C-w>j", desc = "update" },

    { "<leader>p", group = "Pandoc", icon = "" },
    { "<leader>ph", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.html'<CR>", desc = "html" },
    { "<leader>pl", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.tex'<CR>", desc = "latex" },
    { "<leader>pm", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.md'<CR>", desc = "markdown" },
    { "<leader>pp", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.pdf' open=0<CR>", desc = "pdf" },
    { "<leader>pv", "<cmd>TermExec cmd='zathura %:p:r.pdf &' open=0<CR>", desc = "view" },
    { "<leader>pw", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>", desc = "word" },

    { "<leader>r", group = "Run", icon = "" },
    { "<leader>rc", "<cmd>w! | TermExec cmd='g++ -std=c++17 -O2 -Wall %:p:r.cpp -o %:p:r && %:p:r'<CR>", desc = "c++", icon = "" },
    { "<leader>rC", "<cmd>w! | TermExec cmd='gcc -o %:p:r %:p:r.c && %:p:r'<CR>", desc = "c", icon = "" },
    { "<leader>rd", function() vim.diagnostic.open_float(0, { scope = 'line', header = false, focus = false }) end, desc = "diagnostics" },
    { "<leader>rh", "<cmd>w! | TermExec cmd='ghc %:p:r.hs -o %:p:r && %:p:r'<CR>", desc = "haskell", icon = "" },
    { "<leader>rl", "vim.diagnostics.setloclist", desc = "locate errors" },
    { "<leader>rL", "<cmd>VimtexCompile<CR>", desc = "LaTeX" },
    { "<leader>rn", function() vim.diagnostic.goto_next { popup_opts = { show_header = false } } end, desc = "next" },
    { "<leader>rp", function() vim.diagnostic.goto_prev { popup_opts = { show_header = false } } end, desc = "prev" },
    { "<leader>ru", "<cmd>w! | TermExec cmd='uv run %:p:r.py'<CR>", desc = "uv", icon = "󱟾" },

    { "<leader>s", group = "Split", icon = "" },
    { "<leader>sv", "<cmd>vert sb<CR>", desc = "create vertical split", icon = "" },
    { "<leader>sh", "<cmd>split<CR>", desc = "create horizontal split", icon = "" },
    { "<leader>sk", "<cmd>clo<CR>", desc = "Kill split", icon = "" },
    { "<leader>sm", "<cmd>on<CR>", desc = "Max split", icon = "" },

    { "<leader>S", group = "Sessions", icon = "󱂬" },
    { "<leader>Sd", "<cmd>SessionManager delete_session<CR>", desc = "delete" },
    { "<leader>Sl", "<cmd>SessionManager load_session<CR>", desc = "load" },
    { "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", desc = "save" },

    { "<leader>t", group = "Terminal", icon = "" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Floating" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal" },
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },

    { "<leader>x", group = "Execute", icon = "󰳽" },
    { "<leader>xa", "<cmd>lua PdfAnnots()<CR>", desc = "annotate" },
    { "<leader>xb", "<cmd>terminal bibexport -o %:p:r.bib %:p:r.aux<CR>", desc = "bib export" },
    { "<leader>xc", "<cmd>:VimtexClearCache All<CR>", desc = "clear vimtex" },
    { "<leader>xe", "<cmd>VimtexErrors<CR>", desc = "error report" },
    { "<leader>xf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "format" },
    { "<leader>xg", "<cmd>e $MYVIMRC/templates/Glossary.tex<CR>", desc = "edit glossary" },
    { "<leader>xh", "<cmd>LocalHighlightToggle<CR>", desc = "highlight" },
    { "<leader>xk", "<cmd>VimtexClean<CR>", desc = "kill aux" },
    { "<leader>xl", "<cmd>LeanInfoviewToggle<CR>", desc = "lean info" },
    { "<leader>xm", "<cmd>TermExec cmd='python3 ~/Documents/Philosophy/Projects/ModelChecker/Code/src/model_checker %:p:r.py'<CR>", desc = "model checker" },
    { "<leader>xp", "<cmd>TermExec cmd='python3 %:p:r.py'<CR>", desc = "python" },
    -- { "<leader>xr", "<cmd>AutolistRecalculate<CR>", desc = "reorder list" },
    { "<leader>xr", "<cmd>:%s/\\r//g<CR>", desc = "Remove \\r", icon = "󰾠" },
    { "<leader>xs", "<cmd>e $MYVIMRC/snippets/tex.snippets<CR>", desc = "snippets edit" },
    { "<leader>xS", "<cmd>TermExec cmd='ssh brastmck@eofe10.mit.edu'<CR>", desc = "ssh" },
    { "<leader>xt", "<cmd>TermExec<CR>", desc = "terminal" },
    { "<leader>xu", "<cmd>cd %:p:h<CR>", desc = "update cwd" },
    { "<leader>xv", "<plug>(vimtex-context-menu)", desc = "vimtex menu" },
    { "<leader>xw", "<cmd>VimtexCountWords!<CR>", desc = "word count" },
  }

  wk.add(mappings)
end

return M
