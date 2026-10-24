-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.man_hardwrap = 0

require('mappings.default')
require('options')

vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/folke/which-key.nvim' },
})

-- Look and feel
vim.cmd.colorscheme("catppuccin")

require('mini.statusline').setup()

-- Required for mini.files and mini.pick
require('mini.icons').setup()

require('which-key').setup()

-- File Browser

require('mini.files').setup({
  windows = {
    preview = true,
  },
})

vim.keymap.set("n", "<C-n>", function()
  MiniFiles.open()
end)

-- Picker

require('mini.pick').setup()

-- Completion and LSP

vim.lsp.enable({
  "lua_ls",
  "pyright",
})

local gen_loader = require('mini.snippets').gen_loader

require('mini.snippets').setup({
  -- mappings = {
  --   jump_next = '<TAB>',
  --   jump_prev = '<S-TAB>',
  -- },

  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

require('mini.snippets').start_lsp_server({ match = false })

require('mini.completion').setup()

require('mini.cmdline').setup()

require('mini.git').setup()

require('mini.diff').setup()
