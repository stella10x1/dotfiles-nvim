-- plugin file for mini.nvim.

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.statusline").setup()

-- Required for mini.files and mini.pick
require("mini.icons").setup()

-- File Browser
require("mini.files").setup({
  windows = {
    preview = true,
  },
})

vim.keymap.set("n", "<C-n>", function()
  MiniFiles.open()
end)

-- Keep the default <C-n> (cursor down) in CodeDiff panels to move through
-- commits and files together with <C-p>.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "codediff-explorer", "codediff-history" },
  callback = function(ev)
    vim.keymap.set("n", "<C-n>", "<C-n>", { buffer = ev.buf })
  end,
})

require("mini.git").setup()

require("mini.diff").setup()
