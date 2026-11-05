-- plugin file for tree-sitter-manager.nvim.

vim.pack.add({
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

require("tree-sitter-manager").setup({
  -- latex (nested highlighting in markdown) is intentionally not listed:
  -- generating its parser needs a lot of memory and can trigger the OOM
  -- killer on small machines. Install it manually, see README.md.
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "git_config",
    "gitcommit",
    "gitignore",
    "html",
    "ini",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "requirements",
    "toml",
    "xml",
    "yaml",
  },
  -- vimtex relies on its own syntax highlighting (:h vimtex-faq-treesitter)
  nohighlight = { "latex" },
})
