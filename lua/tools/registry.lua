-- Registry of external programs used by this configuration.
--
-- Single source of truth for LSP servers (vim.lsp.enable), formatters
-- (conform.nvim), linters (nvim-lint) and other tools. Keep this file pure
-- Lua (no `vim.*` calls), so it can be read before any plugin is installed.
--
-- Fields:
--   name     name used by the plugin (lspconfig, conform, nvim-lint) or the tool
--   ft       filetypes (formatter, linter); order of entries is run order
--   exe      executable checked by `:checkhealth tools` (default: name),
--            false to skip the check
--   optional true to only warn in `:checkhealth tools`
--   used_by  short note, what needs the tool (tools section)
--   pkg      package names per installer (pacman, pypi, npm, ...)

return {
  lsp = {
    {
      name = "bashls",
      exe = "bash-language-server",
      pkg = { pacman = "bash-language-server", npm = "bash-language-server" },
    },
    { name = "clangd", pkg = { pacman = "clang" } },
    { name = "lua_ls", exe = "lua-language-server", pkg = { pacman = "lua-language-server" } },
    { name = "pyright", exe = "pyright-langserver", pkg = { pacman = "pyright", npm = "pyright", pypi = "pyright" } },
  },

  formatter = {
    { name = "clang-format", ft = { "c", "cpp" }, pkg = { pacman = "clang", pypi = "clang-format" } },
    { name = "gersemi", ft = { "cmake" }, pkg = { pacman = "python-gersemi", pypi = "gersemi" } },
    {
      name = "markdownlint-cli2",
      ft = { "markdown" },
      pkg = { pacman = "markdownlint-cli2", npm = "markdownlint-cli2" },
    },
    {
      name = "prettier",
      ft = { "css", "html", "javascript", "json", "yaml" },
      pkg = { pacman = "prettier", npm = "prettier" },
    },
    { name = "ruff_format", ft = { "python" }, exe = "ruff", pkg = { pacman = "ruff", pypi = "ruff" } },
    { name = "ruff_organize_imports", ft = { "python" }, exe = "ruff", pkg = { pacman = "ruff", pypi = "ruff" } },
    { name = "ruff_fix", ft = { "python" }, exe = "ruff", pkg = { pacman = "ruff", pypi = "ruff" } },
    { name = "stylua", ft = { "lua" }, pkg = { pacman = "stylua" } },
  },

  linter = {
    { name = "cppcheck", ft = { "cpp" }, pkg = { pacman = "cppcheck" } },
    {
      name = "markdownlint-cli2",
      ft = { "markdown" },
      pkg = { pacman = "markdownlint-cli2", npm = "markdownlint-cli2" },
    },
  },

  tools = {
    { name = "neovim", exe = "nvim", used_by = "everything", pkg = { pacman = "neovim" } },
    { name = "git", used_by = "vim.pack, neogit, mini.git", pkg = { pacman = "git" } },
    { name = "curl", used_by = "codediff.nvim (diff library download)", pkg = { pacman = "curl" } },
    { name = "ripgrep", exe = "rg", used_by = "snacks.nvim picker", pkg = { pacman = "ripgrep" } },
    { name = "fd", used_by = "snacks.nvim picker", pkg = { pacman = "fd" } },
    {
      name = "tree-sitter",
      used_by = "tree-sitter-manager.nvim",
      pkg = { pacman = "tree-sitter-cli", npm = "tree-sitter-cli" },
    },
    { name = "gcc", exe = "cc", used_by = "tree-sitter-manager.nvim (building parsers)", pkg = { pacman = "gcc" } },
    { name = "shellcheck", used_by = "bashls (diagnostics)", pkg = { pacman = "shellcheck" } },
    { name = "shfmt", used_by = "bashls (formatting)", pkg = { pacman = "shfmt" } },
    {
      name = "opencode",
      optional = true,
      used_by = "opencode.nvim",
      pkg = { pacman = "opencode", npm = "opencode-ai" },
    },
    { name = "kitty", optional = true, used_by = "vim-kitty-navigator, neogit graph", pkg = { pacman = "kitty" } },
    { name = "zathura", optional = true, used_by = "vimtex (viewer)", pkg = { pacman = "zathura" } },
    {
      name = "zathura-pdf-mupdf",
      exe = false,
      optional = true,
      used_by = "zathura (PDF support)",
      pkg = { pacman = "zathura-pdf-mupdf" },
    },
    { name = "texdoc", optional = true, used_by = "vimtex (documentation)", pkg = { pacman = "texlive-binextra" } },
    { name = "wl-copy", optional = true, used_by = "system clipboard (Wayland)", pkg = { pacman = "wl-clipboard" } },
  },
}
