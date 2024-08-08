return {
  "NeogitOrg/neogit",
  cmd = { "Neogit", "NeogitLogCurrent" },
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  init = function()
    require "mappings.neogit"
  end,
  opts = require "configs.neogit",
}
