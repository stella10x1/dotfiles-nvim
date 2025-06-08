-- plugin file for diffview.

return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  init = function()
    require "mappings.diffview"
  end,
}
