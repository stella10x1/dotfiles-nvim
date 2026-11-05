# AGENTS.md

Guidance for AI coding agents working on this Neovim configuration. Read
[README.md](./README.md) first: its "Structure" section describes the layout
and naming conventions, "Development" the tooling.

## Principles

- **Prefer Neovim built-ins** (`vim.pack`, `vim.fs`, `vim.ui`, `vim.lsp`, ...)
  over plugin APIs. Moving away from plugin-specific machinery was the reason
  for migrating from lazy.nvim to `vim.pack`. Use a plugin API only when no
  built-in fits, and say why.
- **Keep plugins self-contained.** Each `lua/plugins/<name>.lua` calls
  `vim.pack.add()` for the plugin and its dependencies, runs the setup and
  defines its keymaps. Exceptions that belong to a plugin (e.g. undoing its
  keymap for certain filetypes) live in that plugin's file, too.
- **Keep the load order explicit.** `init.lua` requires the plugin files in
  order. Don't auto-load `lua/plugins/` or use the `plugin/` directory for
  this.
- **External programs** (LSP servers, formatters, linters) are registered in
  `lua/tools/registry.lua`, not hard-coded in plugin files.

## Gotchas

- **Lockfile:** `nvim-pack-lock.json` is written by `vim.pack`. Never edit it
  by hand. To remove a plugin, delete its file/`require` and run
  `vim.pack.del({ "name" })`, then commit the updated lockfile.
- **Folder names in the repo root matter:** `~/.config/nvim` is on the
  `runtimepath`, so `doc/`, `plugin/`, `ftplugin/`, `colors/`, ... are read by
  Neovim. Use `assets/` for non-Neovim files.
- **Treesitter parsers:** don't add `latex` to `ensure_installed` (generating
  it can trigger the OOM killer, see README). LaTeX buffers are highlighted by
  vimtex, treesitter is disabled for them via `nohighlight`.
- **snacks.nvim** replaces `vim.ui.select` on `UIEnter`, so in headless tests
  the built-in implementation is used.

## Testing changes

There is no test suite. Verify changes with headless Neovim, e.g.:

```sh
nvim --headless +"lua print(vim.v.errmsg)" +qa
```

- `E216: No such group or event: FileExplorer *` in `v:errmsg` is expected: it
  comes from mini.files disabling netrw with `silent!`.
- Check the actual behavior (keymaps with `maparg()`, loaded modules,
  treesitter state, extmarks, ...), not only that startup succeeds.
- `:checkhealth tools` checks the external programs from the registry.

## Code style

- Lua is formatted with StyLua (`.stylua.toml`): 2 spaces, double quotes,
  parentheses on all calls (`require("x")`), 120 columns.
- Plugin files start with `-- plugin file for <plugin>.` (the plugin's repo
  name), since the file name doesn't always tell (e.g. `lsp.lua` is
  nvim-lspconfig). No footer comment.

## Git

- pre-commit runs StyLua and some default hooks on every commit (see README).
  If a hook modifies files, review, stage and commit again.
- Commit messages: short imperative subject (e.g. "Move zk-nvim to its own
  vim.pack plugin file"), body explaining *why*. Keep commits focused, e.g.
  one commit per plugin.
- Formatting-only commits go into `.git-blame-ignore-revs` (full hash).
- Don't commit to `main` directly and don't push unless asked.
