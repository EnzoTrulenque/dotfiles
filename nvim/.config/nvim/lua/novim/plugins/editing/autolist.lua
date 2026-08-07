return {
  "gaoDean/autolist.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Carrega ao abrir ou criar um arquivo
  dependencies = {
    -- Adicione dependências aqui se usar algum plugin de completude que interaja com ele,
    -- caso contrário, pode manter a lista vazia ou omitir.
  },
  config = function()
    local autolist = require("autolist")

    -- Configuração básica do plugin
    autolist.setup({
      enabled = true,
      -- Você pode adicionar opções específicas aqui caso queira customizar o comportamento
    })

    -- Configurações de Keymaps recomendadas pelo criador do plugin
    -- para que o autolist gerencie o comportamento das quebras de linha e indentação
    local opts = { noremap = true, silent = true }

    vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", opts)
    vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
    vim.keymap.set("n", "O", "O<cmd>AutolistNewBullet<cr>", opts)

    -- Redimensionar/Recalcular as listas ao indentar ou desindentar
    vim.keymap.set("i", "<Tab>", "<Tab><cmd>AutolistTab<cr>", opts)
    vim.keymap.set("i", "<S-Tab>", "<S-Tab><cmd>AutolistShiftTab<cr>", opts)
    vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>", opts)
    vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>", opts)
    vim.keymap.set("v", ">", "><cmd>AutolistRecalculate<cr>", opts)
    vim.keymap.set("v", "<", "<<cmd>AutolistRecalculate<cr>", opts)

    -- Atalhos úteis para alternar tipos de listas (marcador <-> numeração)
    vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>", opts)
    vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCyclePrev<cr>", opts)

    -- Sincronizar numerações após deleções (ex: dd)
    --[[ vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
    vim.keymap.set("n", "d", "d<cmd>AutolistRecalculate<cr>", opts)
    vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>", opts) ]]
  end,
}
