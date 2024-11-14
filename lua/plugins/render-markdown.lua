-- plugin file for render-markdown.

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  cmd = { "RenderMarkdown" },
  init = function()
    require "mappings.render-markdown"
  end,
}

-- End of file.
