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
  { src = 'https://github.com/knubie/vim-kitty-navigator' },
  { src = 'https://github.com/saghen/blink.indent' },
  { src = 'https://github.com/jghauser/follow-md-links.nvim' },
  { src = 'https://gitlab.com/HiPhish/info.vim' },
  { src = 'https://github.com/HiPhish/jinja.vim' },
  { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  { src = 'https://github.com/zk-org/zk-nvim' },
})

-- Look and feel
vim.cmd.colorscheme("catppuccin")

vim.keymap.set("n", "<leader>d", function()
  return vim.diagnostic.open_float()
end, { desc = "Open float diagnostic" })

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

require("plugins.snacks")

-- Completion and LSP

require("plugins.lazydev")

vim.lsp.enable(require("tools").lsp())

require("plugins.luasnip")
require("plugins.blink")

require('mini.git').setup()

require('mini.diff').setup()

require("plugins.conform")

vim.keymap.set("n", "<leader>tm", "<cmd> TableModeToggle<CR>", { desc = "Toggle Table Mode" })

require("plugins.zk")

require("plugins.neogit")
require("plugins.opencode")
require("plugins.render-markdown")
require("plugins.tree-sitter-manager")
require("plugins.codediff")
require("plugins.vimtex")
require("plugins.lint")
