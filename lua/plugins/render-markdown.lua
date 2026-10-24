-- plugin file for render-markdown.

vim.pack.add {
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
}

require("render-markdown").setup {
  anti_conceal = {
    enabled = false,
  },
  enabled = true,
  file_types = { "markdown", "opencode_output" },
}

vim.keymap.set("n", "<leader>tr", "<cmd> RenderMarkdown toggle<CR>", { desc = "Toggle Rendering markdown" })
