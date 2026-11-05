-- plugin file for blink.cmp.

vim.pack.add({
  -- release tag is required to download the pre-built fuzzy matcher binary
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority
        score_offset = 100,
      },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  -- Disable completion in snacks picker
  pattern = "snacks_picker_input",
  callback = function()
    vim.b.completion = false
  end,
})

-- End of file.
