-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.man_hardwrap = 0

require('mappings.default')
require('options')

vim.pack.add({
  { src = 'https://github.com/saghen/blink.indent' },
  { src = 'https://github.com/jghauser/follow-md-links.nvim' },
  { src = 'https://gitlab.com/HiPhish/info.vim' },
  { src = 'https://github.com/HiPhish/jinja.vim' },
  { src = 'https://github.com/dhruvasagar/vim-table-mode' },
})

-- Look and feel
vim.cmd.colorscheme("catppuccin")

require("plugins.mini")

require("plugins.which-key")
require("plugins.kitty-navigator")

require("plugins.snacks")

-- Completion and LSP

require("plugins.lazydev")

require("plugins.lsp")

require("plugins.luasnip")
require("plugins.blink")

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
