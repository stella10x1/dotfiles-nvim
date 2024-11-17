-- plugin file for telescope-bibtex.

return {
  "nvim-telescope/telescope-bibtex.nvim",
  config = function()
    require("telescope").load_extension "bibtex"
  end,
  ft = { "tex", "markdown" },
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
}

-- End of file.
