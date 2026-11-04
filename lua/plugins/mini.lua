-- plugin file for mini.nvim.

vim.pack.add {
  { src = "https://github.com/nvim-mini/mini.nvim" },
}

require("mini.statusline").setup()

-- Required for mini.files and mini.pick
require("mini.icons").setup()

-- File Browser
require("mini.files").setup {
  windows = {
    preview = true,
  },
}

vim.keymap.set("n", "<C-n>", function()
  MiniFiles.open()
end)

require("mini.git").setup()

require("mini.diff").setup()

-- End of file.
