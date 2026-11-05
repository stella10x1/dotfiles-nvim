vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/sudo-tee/opencode.nvim" },
})

require("opencode").setup({
  ui = {
    picker = {
      ---@module "snacks"
      ---@type snacks.picker.layout.Config | nil
      snacks_layout = {
        preset = "select",
      },
    },
  },
})
