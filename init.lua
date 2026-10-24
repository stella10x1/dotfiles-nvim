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
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/jghauser/follow-md-links.nvim' },
  { src = 'https://gitlab.com/HiPhish/info.vim' },
  { src = 'https://github.com/HiPhish/jinja.vim' },
  { src = 'https://github.com/folke/lazydev.nvim' },
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

vim.lsp.enable(require("tools").lsp())

require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  integrations = {
    cmp = false,
  },
  enabled = function(root_dir)
    -- explicit per-project override via exrc wins
    if vim.g.lazydev_enabled ~= nil then
      return vim.g.lazydev_enabled
    end
    -- projects with their own .luarc.json aren't Neovim config/plugins
    return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
  end,
}

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

vim.api.nvim_create_autocmd("FileType", {
  -- Disable mini completion in snacks picker
  pattern = "snacks_picker_input",
  callback = function()
    vim.b.minicompletion_disable = true
  end,
})

require('mini.cmdline').setup()

require('mini.git').setup()

require('mini.diff').setup()

require('conform').setup({
  formatters_by_ft = require("tools").formatters_by_ft(),
})

vim.keymap.set("n", "<leader>FF", function()
  require("conform").format()
end, { desc = "Buffer Code formatting" })

vim.keymap.set("n", "<leader>tm", "<cmd> TableModeToggle<CR>", { desc = "Toggle Table Mode" })

require("plugins.zk")

require("plugins.neogit")
require("plugins.opencode")
require("plugins.render-markdown")
require("plugins.tree-sitter-manager")
require("plugins.codediff")
require("plugins.vimtex")
require("plugins.lint")
