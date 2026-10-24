vim.pack.add {
  { src = "https://github.com/folke/snacks.nvim" },
}

require("snacks").setup {
  picker = { enabled = true },
}

-- Terminal Keymaps (formerly provided by NvChad)

-- toggleable terminals, the env makes each position its own terminal
vim.keymap.set({ "n", "t" }, "<A-h>", function()
  return require("snacks").terminal.toggle(nil, { env = { SNACKS_TERM = "horizontal" }, win = { position = "bottom" } })
end, { desc = "Terminal Toggle horizontal term" })

vim.keymap.set({ "n", "t" }, "<A-v>", function()
  return require("snacks").terminal.toggle(nil, { env = { SNACKS_TERM = "vertical" }, win = { position = "right" } })
end, { desc = "Terminal Toggle vertical term" })

vim.keymap.set({ "n", "t" }, "<A-i>", function()
  return require("snacks").terminal.toggle(nil, { env = { SNACKS_TERM = "float" }, win = { position = "float" } })
end, { desc = "Terminal Toggle floating term" })

-- new terminals
vim.keymap.set("n", "<leader>H", function()
  return require("snacks").terminal.open(nil, { win = { position = "bottom" } })
end, { desc = "Terminal New horizontal term" })

vim.keymap.set("n", "<leader>V", function()
  return require("snacks").terminal.open(nil, { win = { position = "right" } })
end, { desc = "Terminal New vertical term" })

-- Picker Keymaps

vim.keymap.set("n", "<leader>D", function()
  return require("snacks").picker.diagnostics()
end, { desc = "Pick diagnostics (buffer)" })

vim.keymap.set("n", "<leader>e", function()
  return require("snacks").picker.explorer()
end, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>fb", function()
  return require("snacks").picker.buffers()
end, { desc = "Pick buffer" })

vim.keymap.set("n", "<leader>fc", function()
  return require("snacks").picker.commands()
end, { desc = "Pick available commands" })

vim.keymap.set("n", "<leader>fC", function()
  return require("snacks").picker.command_history()
end, { desc = "Pick command history" })

vim.keymap.set("n", "<leader>fd", function()
  return require("snacks").picker.diagnostics_buffer()
end, { desc = "Pick diagnostics (project)" })

vim.keymap.set("n", "<leader>ff", function()
  return require("snacks").picker.files()
end, { desc = "Pick all files (gitignored, but no hidden)" })

vim.keymap.set("n", "<leader>fh", function()
  return require("snacks").picker.help()
end, { desc = "Pick help tags" })

vim.keymap.set("n", "<leader>fk", function()
  return require("snacks").picker.keymaps()
end, { desc = "Pick keymaps" })

vim.keymap.set("n", "<leader>fl", function()
  return require("snacks").picker.grep()
end, { desc = "Pick live grep" })

vim.keymap.set("n", "<leader>fm", function()
  return require("snacks").picker.man()
end, { desc = "Pick man pages" })

vim.keymap.set("n", "<leader>fr", function()
  return require("snacks").picker.lsp_references()
end, { desc = "Pick LSP references" })

vim.keymap.set("n", "<leader>fs", function()
  return require("snacks").picker.lsp_symbols()
end, { desc = "Pick LSP symbols (classes, functions, etc.)" })

vim.keymap.set("n", "<leader>ft", function()
  return require("snacks").picker.treesitter()
end, { desc = "Pick treesitter" })

vim.keymap.set("n", "<leader>fT", function()
  return require("snacks").picker.colorschemes()
end, { desc = "Pick themes (colorschemes)" })

vim.keymap.set("n", "<leader>fz", function()
  return require("snacks").picker.spelling()
end, { desc = "Pick spell corrections" })

vim.keymap.set("n", "<leader>f\"", function()
  return require("snacks").picker.registers()
end, { desc = "Pick registers" })

vim.keymap.set("n", "<leader>gb", function()
  return require("snacks").picker.git_branches()
end, { desc = "Pick git branches" })

vim.keymap.set("n", "<leader>gC", function()
  return require("snacks").picker.git_log()
end, { desc = "Pick git checkout from log" })

vim.keymap.set("n", "<leader>gd", function()
  return require("snacks").picker.git_diff()
end, { desc = "Pick git diffs" })

vim.keymap.set("n", "<leader>gf", function()
  return require("snacks").picker.git_files()
end, { desc = "Pick git files" })

vim.keymap.set("n", "<leader>gg", function()
  return require("snacks").picker.git_grep()
end, { desc = "Pick git grep" })

vim.keymap.set("n", "<leader>gz", function()
  return require("snacks").picker.git_stashes()
end, { desc = "Pick git stashes" })

vim.keymap.set("n", "<leader>P", function()
  return require("snacks").picker()
end, { desc = "Pick pickers (show all pickers)" })
