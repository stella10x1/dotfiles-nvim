-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.man_hardwrap = 0

require("keymaps")
require("options")
require("filetypes-custom")

-- Look and feel
vim.cmd.colorscheme("catppuccin")

require("plugins.mini")
require("plugins.blink-indent")

require("plugins.which-key")
require("plugins.kitty-navigator")

require("plugins.snacks")

-- Completion and LSP

require("plugins.lazydev")

require("plugins.lsp")

require("plugins.luasnip")
require("plugins.blink-cmp")

require("plugins.conform")

require("plugins.table-mode")
require("plugins.follow-md-links")
require("plugins.info")
require("plugins.jinja")

require("plugins.zk")

require("plugins.neogit")
require("plugins.opencode")
require("plugins.render-markdown")
require("plugins.tree-sitter-manager")
require("plugins.codediff")
require("plugins.vimtex")
require("plugins.lint")
