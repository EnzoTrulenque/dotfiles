-- ==============================================================================
-- lua/novim/core/keymaps.lua
-- Central de Atalhos (Nativos e Which-Key)
-- ==============================================================================

vim.g.mapleader = " "

local map = vim.keymap.set
-- vim.keymap.set já aplica 'noremap = true' por padrão, só precisamos do silent
local opts = function(desc)
  return { silent = true, desc = desc }
end

local custom_functions = require("novim.core.functions")

-- ==============================================================================
-- 1. Atalhos Nativos do Neovim (Com descrições para o Which-Key ler)
-- ==============================================================================

-- Unmappings
map("n", "<C-z>", "<nop>", opts("Desabilitar suspensão (C-z)"))
map("n", "gc", "<nop>", opts(""))
map("n", "gcc", "<nop>", opts(""))
map("i", "<C-n>", "<nop>", opts(""))

-- Utilidades
map("n", "<C-t>", "<cmd>Floaterminal<CR>", opts("Terminal Flutuante"))
map("n", "<C-s>", custom_functions.telescope_spell_suggest, opts("Sugestão de Ortografia"))
map("n", "<CR>", "<cmd>noh<CR>", opts("Limpar realce de busca"))
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts("Buscar arquivos (Telescope)"))
map("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts("Help na palavra sob o cursor"))
map("n", "<C-;>", custom_functions.add_semicolon_at_end, opts("Adicionar ';' no fim da linha"))

-- <C-p>: Mostra a assinatura da função (Parâmetros) usando o LSP
map("i", "<C-p>", function() vim.lsp.buf.signature_help() end, opts("LSP: Mostrar parâmetros da função"))

-- Navegação na linha de comandos

map("c", "<C-j>", "<Down>", opts("Próximo comando no histórico"))
map("c", "<C-k>", "<Up>", opts("Comando anterior no histórico"))

-- Comentários
map('n', "<C-/>", '<Plug>(comment_toggle_linewise_current)', opts("Alternar comentário (Linha)"))
map('x', "<C-/>", '<Plug>(comment_toggle_blockwise_visual)', opts("Alternar comentário (Bloco Visual)"))

-- Movimentação e Edição (Overrides)
map({ "n", "v" }, "Y", "y$", opts("Yank até o fim da linha"))
map({ "n", "v" }, "E", "ge", opts("Ir para o fim da palavra anterior"))
-- CUIDADO: Mapear 'm' sobrescreve a funcionalidade nativa de criar 'marks' (marcações) no Neovim.
map({ "n", "v" }, "m", "zt", opts("Centralizar cursor no topo"))

-- Navegação entre Janelas
map("n", "<C-h>", "<C-w>h", opts("Janela Esquerda"))
map("n", "<C-j>", "<C-w>j", opts("Janela Baixo"))
map("n", "<C-k>", "<C-w>k", opts("Janela Cima"))
map("n", "<C-l>", "<C-w>l", opts("Janela Direita"))

-- Redimensionamento de Janelas
map("n", "<A-Up>", ":resize -2<CR>", opts("Diminuir altura da janela"))
map("n", "<A-Down>", ":resize +2<CR>", opts("Aumentar altura da janela"))
map("n", "<A-Left>", ":vertical resize -2<CR>", opts("Diminuir largura da janela"))
map("n", "<A-Right>", ":vertical resize +2<CR>", opts("Aumentar largura da janela"))
map("n", "<A-h>", ":vertical resize -2<CR>", opts("Diminuir largura da janela"))
map("n", "<A-l>", ":vertical resize +2<CR>", opts("Aumentar largura da janela"))

-- Navegação de Buffers (Respeitando a ordem visual do Bufferline)
map("n", "<TAB>", ":BufferLineCycleNext<CR>", opts("Próximo Buffer"))
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opts("Buffer Anterior"))
map("n", "<BS>", ":BufferLineMovePrev<CR>", opts("Mover aba para esquerda"))
map("n", "<S-BS>", ":BufferLineMoveNext<CR>", opts("Mover aba para direita"))

-- Mover Linhas
map("n", "<A-j>", custom_functions.move_line_down, opts("Mover linha atual para baixo"))
map("n", "<A-k>", custom_functions.move_line_up, opts("Mover linha atual para cima"))
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts("Mover bloco para baixo"))
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts("Mover bloco para cima"))
map("v", "<A-j>", ":m'>+<CR>gv", opts("Mover seleção para baixo"))
map("v", "<A-k>", ":m-2<CR>gv", opts("Mover seleção para cima"))

-- Movimentação Horizontal Extrema
map({ "n", "v" }, "<S-h>", "g^", opts("Início da linha visual"))
map({ "n", "v" }, "<S-l>", "g$", opts("Fim da linha visual"))

-- Movimentação Vertical em Linhas Quebradas (Wrap)
map({ "n", "v" }, "J", "gj", opts("Descer linha visual"))
map({ "n", "v" }, "K", "gk", opts("Subir linha visual"))

-- Indentação (Mantendo a seleção visual)
map("v", "<", "<gv", opts("Diminuir recuo"))
map("v", ">", ">gv", opts("Aumentar recuo"))
map("n", "<", "<<", opts("Diminuir recuo"))
map("n", ">", ">>", opts("Aumentar recuo"))

-- ==============================================================================
-- 2. Atalhos de Leader (via Which-Key)
-- ==============================================================================

local M = {}

-- Criamos uma função que será chamada pelo plugin apenas quando ele estiver pronto
function M.load_which_key_mappings()
  local wk_ok, wk = pcall(require, "which-key")
  if not wk_ok then return end

  wk.add({
    -- Atalhos de Nível Superior
    { "<leader>d", "<cmd>update! | lua require('mini.bufremove').delete(0, false)<CR>", desc = "Delete buffer", icon = "" },
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer", icon = "󰥩" },
    { "<leader>h", "<cmd>Alpha<CR>", desc = "Home", icon = "" },
    { "<leader>i", "<cmd>VimtexTocOpen<CR>", desc = "Index" },
    { "<leader>q", "<cmd>wa! | qa!<CR>", desc = "Quit", icon = "󰈆" },
    { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo history", icon = "" },
    { "<leader>v", "<cmd>VimtexView<CR>", desc = "View" },
    { "<leader>w", "<cmd>w!<CR>", desc = "Write", icon = "" },
    { "<leader>Y", "<cmd>%y<CR>", desc = "Yank all", icon = "" },
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen", icon = "󱅻" },

    -- Ai
    { "<leader>a", group = "Ai", icon = "" },
    { "<leader>ai", "<cmd>Copilot toggle<CR>", desc = "Copilot inline", icon = "" },
    { "<leader>aC", "<cmd>CopilotChatToggle<CR>", desc = "Copilot Chat", icon = "" },

    -- Find
    { "<leader>f", group = "Find", icon = "" },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", desc = "buffers" },
    { "<leader>fc", "<cmd>Telescope bibtex format_string=\\citet{%s}<CR>", desc = "citations" },
    { "<leader>ff", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "project", icon = "" },
    { "<leader>fg", "<cmd>Telescope git_commits<CR>", desc = "git history" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "keymaps" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "recent" },
    { "<leader>fr", "<cmd>Telescope registers<CR>", desc = "registers" },
    { "<leader>ft", "<cmd>Telescope colorscheme<CR>", desc = "theme" },
    { "<leader>fw", "<cmd>lua SearchWordUnderCursor()<CR>", desc = "word" },
    { "<leader>fy", "<cmd>YankyRingHistory<CR>", desc = "yanks" },

    -- Git
    { "<leader>g", group = "Git", icon = "󰊢" },
    { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "checkout branch" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "diff" },
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
    { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", desc = "next hunk" },
    { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", desc = "prev hunk" },
    { "<leader>gl", "<cmd>Gitsigns blame_line<CR>", desc = "line blame" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "preview hunk" },
    { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "toggle blame" },

    -- List
    { "<leader>L", group = "List", icon = "󰦏" },
    { "<leader>Lc", "<cmd>lua HandleCheckbox()<CR>", desc = "checkbox" },
    { "<leader>Ln", "<cmd>AutolistCycleNext<CR>", desc = "next" },
    { "<leader>Lp", "<cmd>AutolistCyclePrev<CR>", desc = "previous" },
    { "<leader>Lr", "<cmd>AutolistRecalculate<CR>", desc = "reorder" },

    -- LSP
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

    -- Markdown
    { "<leader>m", group = "Markdown", icon = "" },
    { "<leader>mv", "<cmd>Slides<CR>", desc = "view slides" },

    -- NixOS
    { "<leader>n", group = "NixOS", icon = "" },
    { "<leader>nd", "<cmd>TermExec cmd='nix develop'<CR><C-w>j", desc = "develop" },
    { "<leader>ng", "<cmd>TermExec cmd='nix-collect-garbage --delete-older-than 15d'<CR><C-w>j", desc = "garbage" },
    { "<leader>nh", "<cmd>TermExec cmd='home-manager switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "home-manager" },
    { "<leader>nm", "<cmd>TermExec cmd='brave https://mynixos.com' open=0<CR>", desc = "my-nixos" },
    { "<leader>np", "<cmd>TermExec cmd='brave https://search.nixos.org/packages' open=0<CR>", desc = "packages" },
    { "<leader>nr", "<cmd>TermExec cmd='sudo nixos-rebuild switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "rebuild flake" },
    { "<leader>nu", "<cmd>TermExec cmd='nix flake update'<CR><C-w>j", desc = "update" },

    -- Pandoc
    { "<leader>p", group = "Pandoc", icon = "" },
    { "<leader>ph", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.html'<CR>", desc = "html" },
    { "<leader>pl", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.tex'<CR>", desc = "latex" },
    { "<leader>pm", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.md'<CR>", desc = "markdown" },
    { "<leader>pp", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.pdf' open=0<CR>", desc = "pdf" },
    { "<leader>pv", "<cmd>TermExec cmd='zathura %:p:r.pdf &' open=0<CR>", desc = "view" },
    { "<leader>pw", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>", desc = "word" },

    -- Run
    { "<leader>r", group = "Run", icon = "" },
    { "<leader>rc", "<cmd>w! | TermExec cmd='g++ -std=c++17 -O2 -Wall %:p:r.cpp -o %:p:r && %:p:r'<CR>", desc = "c++", icon = "" },
    { "<leader>rC", "<cmd>w! | TermExec cmd='gcc -o %:p:r %:p:r.c && %:p:r'<CR>", desc = "c", icon = "" },
    { "<leader>rd", function() vim.diagnostic.open_float({ scope = 'line', header = "", focus = false }) end, desc = "diagnostics" },
    { "<leader>rh", "<cmd>w! | TermExec cmd='ghc %:p:r.hs -o %:p:r && %:p:r'<CR>", desc = "haskell", icon = "" },
    { "<leader>rj", "<cmd>w! | TermExec cmd='java %:p'<CR>", desc = "java", icon = "" },
    { "<leader>rl", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "locate errors" },
    { "<leader>rL", "<cmd>VimtexCompile<CR>", desc = "LaTeX" },
    { "<leader>rn", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "next" },
    { "<leader>rp", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "prev" },
    { "<leader>ru", "<cmd>w! | TermExec cmd='uv run %:p:r.py'<CR>", desc = "uv", icon = "󱟾" },

    -- Replace
    { "<leader>R", group = "Replace", icon = "󰛔", mode = { "n", "v" } },
    { "<leader>Rw", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", desc = "word (file)", mode = "n" },
    { "<leader>Rc", ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>", desc = "word confirm", mode = "n" },
    { "<leader>Rl", ":s/\\<<C-r><C-w>\\>//g<Left><Left>", desc = "word (line)", mode = "n" },
    -- Mapeamento visual: copia a seleção para o registro 'h' e joga na linha de comando
    { "<leader>R", '"hy:%s/<C-r>h//g<Left><Left>', desc = "visual selection", mode = "v" },

    -- Split
    { "<leader>s", group = "Split", icon = "" },
    { "<leader>sv", "<cmd>vert sb<CR>", desc = "create vertical split", icon = "" },
    { "<leader>sh", "<cmd>split<CR>", desc = "create horizontal split", icon = "" },
    { "<leader>sk", "<cmd>clo<CR>", desc = "Kill split", icon = "" },
    { "<leader>sm", "<cmd>on<CR>", desc = "Max split", icon = "" },

    -- Sessions
    { "<leader>S", group = "Sessions", icon = "󱂬" },
    { "<leader>Sd", "<cmd>SessionManager delete_session<CR>", desc = "delete" },
    { "<leader>Sl", "<cmd>SessionManager load_session<CR>", desc = "load" },
    { "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", desc = "save" },

    -- Terminal
    { "<leader>t", group = "Terminal", icon = "" },
    -- Terminal 1: Flutuante
    { "<leader>tf", "<cmd>1ToggleTerm direction=float<CR>", desc = "Floating" },
    -- Terminal 2: Horizontal (embaixo)
    { "<leader>th", "<cmd>2ToggleTerm direction=horizontal size=15<CR>", desc = "Horizontal" },
    -- Terminal 3: Vertical (na direita)
    { "<leader>tv", "<cmd>3ToggleTerm direction=vertical size=50<CR>", desc = "Vertical Right" },
    -- Alterna o terminal padrão (Terminal 1)
    { "<leader>tt", "<cmd>1ToggleTerm<CR>", desc = "Toggle Default" },

    -- Execute
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
    { "<leader>xr", "<cmd>:%s/\\r//g<CR>", desc = "Remove \\r", icon = "󰾠" },
    { "<leader>xs", "<cmd>e $MYVIMRC/snippets/tex.snippets<CR>", desc = "snippets edit" },
    { "<leader>xS", "<cmd>TermExec cmd='ssh brastmck@eofe10.mit.edu'<CR>", desc = "ssh" },
    { "<leader>xt", "<cmd>TermExec<CR>", desc = "terminal" },
    { "<leader>xu", "<cmd>cd %:p:h<CR>", desc = "update cwd" },
    { "<leader>xv", "<plug>(vimtex-context-menu)", desc = "vimtex menu" },
    { "<leader>xw", "<cmd>VimtexCountWords!<CR>", desc = "word count" },

    { "<leader>y", group = "Yazi", icon = "󰇥" },
    { "<leader>yh", "<cmd>Yazi<cr>", desc = "open this buffer's dir", icon = "󰈔" },
    { "<leader>yc", "<cmd>Yazi cwd<cr>", desc = "open cwd", icon = "" },
    { "<leader>yr", "<cmd>Yazi toggle<cr>", desc = "last session", icon = "󰒮" },
  })
end

return M
