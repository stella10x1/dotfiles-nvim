-- plugin file for lazydev.

vim.pack.add({
  { src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
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
})

-- End of file.
