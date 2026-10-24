vim.pack.add {
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
}

require("tree-sitter-manager").setup {
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
}
