-- plugin file for render-markdown.

vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("render-markdown").setup({
  anti_conceal = {
    enabled = false,
  },
  enabled = true,
  file_types = { "markdown", "opencode_output" },
  overrides = {
    filetype = {
      -- only render opencode.nvim output by default, toggle markdown buffers
      -- with <leader>tr
      markdown = { enabled = false },
    },
  },
})

vim.keymap.set("n", "<leader>tr", "<cmd> RenderMarkdown buf_toggle<CR>", { desc = "Toggle Rendering markdown" })
