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
  { src = 'https://github.com/folke/snacks.nvim' },
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

require("snacks").setup({
  { picker = { enabled = true }},
})

vim.keymap.set("n", "<leader>P", function()
  return require('snacks').picker()
end, { desc = "Pick pickers (show all pickers)" })

vim.keymap.set("n", "<leader>e", function()
  return require('snacks').picker.explorer()
end, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>ff", function()
  return require('snacks').picker.files()
end, { desc = "Pick all files (gitignored, but no hidden)" })

vim.keymap.set("n", "<leader>fb", function()
  return require('snacks').picker.buffers()
end, { desc = "Pick buffer" })

vim.keymap.set("n", "<leader>fh", function()
  return require('snacks').picker.help()
end, { desc = "Pick help tags" })

vim.keymap.set("n", "<leader>fl", function()
  return require('snacks').picker.grep()
end, { desc = "Pick live grep" })

vim.keymap.set("n", "<leader>gb", function()
  return require('snacks').picker.git_branches()
end, { desc = "Pick git branches" })

-- Completion and LSP

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
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
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "markdownlint-cli2" },
    python = { "black" },
    yaml = { "prettier" },
  },
})

vim.keymap.set("n", "<leader>FF", function()
  require("conform").format()
end, { desc = "Buffer Code formatting" })

require("plugins.neogit")
