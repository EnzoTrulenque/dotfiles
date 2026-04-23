-- ==============================================================================
-- lua/novim/core/options.lua
-- Configurações Nativas do Editor
-- ==============================================================================

local opt = vim.opt

-- ==============================================================================
-- 1. Geral e Desempenho
-- ==============================================================================
opt.timeoutlen = 300    -- Tempo (ms) aguardando completar um atalho (Ex: de 10000 para 300)
opt.updatetime = 200    -- Tempo (ms) de inatividade para salvar o swap e acionar CursorHold (ótimo para LSP)
opt.swapfile = false    -- Desativa arquivos de swap (.swp)
opt.undofile = true     -- Mantém o histórico de 'undo' mesmo após fechar o arquivo
opt.writebackup = false -- Previne edição concorrente por outros programas
opt.lazyredraw = true   -- Não redesenha a tela no meio da execução de macros (Performance)
opt.autoread = true     -- Recarrega o arquivo se foi alterado fora do Neovim

-- ==============================================================================
-- 2. Aparência e Interface
-- ==============================================================================
opt.fileencoding = "utf-8"    -- Codificação padrão de escrita
opt.guifont = "monospace:h17" -- Fonte para GUIs do Neovim (ex: Neovide)
opt.background = "dark"       -- Força o tema a usar variantes escuras
opt.termguicolors = true      -- Habilita cores 24-bit RGB (Essencial para temas modernos)
opt.conceallevel = 0          -- Permite ver caracteres de marcação (ex: `` em markdown)
opt.cmdheight = 1             -- Altura da linha de comando inferior
opt.pumheight = 7             -- Altura máxima do menu popup (autocompletar)
opt.showmode = false          -- Oculta "-- INSERT --" nativo (o Lualine já mostra isso)
opt.shortmess:append("c")     -- Suprime mensagens desnecessárias de conclusão (filnxtToOFc + c)

-- Colunas e Linhas
opt.number = true             -- Mostra números absolutos das linhas
opt.relativenumber = true     -- Mostra números relativos (excelente para pulos com 'j' e 'k')
opt.numberwidth = 2           -- Largura mínima da coluna de números
opt.signcolumn = "yes"        -- Sempre mostra a coluna de sinais (LSP/Git) para a tela não pular
opt.statuscolumn = "%s%l %r"  -- Formato visual: [Sinais][LinhaAbsoluta] [LinhaRelativa]
opt.fillchars = { eob = " " } -- Esconde os '~' no final do arquivo (End of Buffer)
opt.cursorline = true         -- Destaca a linha atual do cursor
opt.laststatus = 3            -- Statusline única e global para todos os splits

-- ==============================================================================
-- 3. Comportamento de Tela e Splits
-- ==============================================================================
opt.wrap = true           -- Quebra visualmente linhas muito longas
opt.showbreak = "  "      -- Recuo visual para linhas quebradas
opt.linebreak = true      -- Quebra linhas inteiras em palavras (não corta a palavra no meio)
opt.splitbelow = true     -- Novos splits horizontais abrem abaixo
opt.splitright = true     -- Novos splits verticais abrem à direita
opt.scrolloff = 7         -- Mantém 7 linhas de margem acima/abaixo do cursor ao rolar a tela
opt.sidescrolloff = 7     -- Mantém 7 colunas de margem lateral ao rolar a tela
opt.mousemoveevent = true -- Permite eventos de hover do mouse (útil para plugins)

-- ==============================================================================
-- 4. Indentação
-- ==============================================================================
opt.tabstop = 2                    -- Um TAB equivale a 2 espaços
opt.shiftwidth = 2                 -- Tamanho do recuo automático (>>, <<)
opt.softtabstop = 2                -- Espaços inseridos ao apertar TAB no modo inserção
opt.expandtab = true               -- Converte TABS reais em espaços
opt.breakindent = true             -- Linhas quebradas visualmente mantêm a indentação da linha original
opt.backspace = "indent,eol,start" -- Comportamento moderno do backspace

-- ==============================================================================
-- 5. Edição, Busca e Área de Transferência
-- ==============================================================================
opt.spell = true                -- Habilita corretor ortográfico
opt.spelllang = { "pt", "en" }  -- Dicionários utilizados
opt.clipboard = "unnamedplus"   -- Sincroniza com a área de transferência do sistema operativo
opt.mouse = "a"                 -- Habilita o mouse em todos os modos
opt.mousescroll = "ver:2,hor:4" -- Sensibilidade do scroll do mouse
opt.ignorecase = true           -- Ignora maiúsculas/minúsculas ao buscar (ex: /teste acha TESTE)
opt.smartcase = true            -- O ignora maiúsculas falha se você digitar uma Maiúscula na busca
opt.virtualedit = "block"       -- Permite que o cursor vá além do fim da linha no modo visual block
opt.inccommand = "split"        -- Mostra o preview de substituições (%s/a/b) em um split ao vivo
