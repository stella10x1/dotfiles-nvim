<div align="center">
  <h1>
    dotfiles-nvim<br>
    <img src="assets/icon.png" alt="dotfiles-nvim icon" width="254">
  </h1>
</div>

This are my [Neovim](https://neovim.io/) dotfiles.

> [!note]
> In the past this configuration was based on [NvChad][NvChad]. However, my
> ideas shifted and so I started to configure the plugins from scratch. I also
> migrated from [lazy.nvim][lazy.nvim] to Neovim's own plugin manager
> `vim.pack`.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/stella10x1/dotfiles-nvim ~/.config/nvim
    ```

2. Install packages on Arch Linux:

    ```bash
    nvim -l ~/.config/nvim/scripts/packages.lua pacman |
      sudo pacman -S --needed -
    ```

## Structure

```text
init.lua              leader keys, options, requires all plugin files in order
nvim-pack-lock.json   vim.pack lockfile (commit it!)
lua/
├── options.lua       global options
├── keymaps.lua       keymaps not tied to a plugin
├── plugins/          one file per plugin
├── tools/            registry of external programs (LSPs, formatters, ...)
└── *.lua             helpers (utils.lua, zk_funcs.lua, filetypes-custom.lua)
ftplugin/             filetype settings, after/ftplugin/ to override built-ins
lua_snippets/         LuaSnip snippets per filetype
scripts/              helper scripts, e.g. package lists for the installer
assets/               images used in this README
```

### Plugins

Each file in `lua/plugins/` is self-contained: it calls `vim.pack.add()` for
the plugin (and its dependencies), runs the setup and defines the plugin's
keymaps. `init.lua` requires the files explicitly, so the load order is
visible there (e.g. `snacks` before `zk`, `luasnip` before `blink`). To
disable a plugin, comment out its `require`. To remove it from disk as well,
run `:lua vim.pack.del({ "name" })` and commit the updated lockfile.

Files are named after the plugin without `nvim-`/`vim-` prefixes and
`.nvim`/`.vim` suffixes, e.g. `vim-table-mode` → `table-mode.lua`,
`zk-nvim` → `zk.lua`. Exceptions: `lsp.lua` (nvim-lspconfig) and `blink.lua`
(blink.cmp).

### Tools

`lua/tools/registry.lua` is the single source of truth for external programs:
LSP servers (`vim.lsp.enable`), formatters (conform.nvim), linters (nvim-lint)
and their package names. `:checkhealth tools` checks that they are installed,
and `scripts/packages.lua` prints the packages for an installer.

## Development

### pre-commit

Lua files are formatted with [StyLua][StyLua] (config in `.stylua.toml`).
Additionally, some of the default [pre-commit-hooks][pre-commit-hooks] validate
JSON/TOML/YAML (e.g. `nvim-pack-lock.json`) and fix trailing whitespace, line
endings and missing newlines at the end of files. [pre-commit][pre-commit] runs
all hooks on every commit:

```bash
# install the git hook once per clone
pre-commit install

# optionally format all files
pre-commit run --all-files
```

If the hook reformats files, the commit is aborted. Review the changes, stage
them and commit again.

### git blame

Formatting-only commits are listed in `.git-blame-ignore-revs`, so `git blame`
shows the commit that actually changed a line. GitHub picks this file up
automatically. For local `git blame` (and blame in Neovim), enable it once per
clone:

```bash
git config blame.ignoreRevsFile .git-blame-ignore-revs
```

When adding another formatting-only commit, append its full hash to the file.

## License and re-use

The code in this dotfile repository is licensed under [the Unlicense](./LICENSE)
(also see [unlicense.org](https://unlicense.org/)).

Feel free to use any code of this repository in your dotfiles!

[NvChad]: https://github.com/NvChad/NvChad
[lazy.nvim]: https://lazy.folke.io/
[pre-commit]: https://pre-commit.com/
[pre-commit-hooks]: https://github.com/pre-commit/pre-commit-hooks
[StyLua]: https://github.com/JohnnyMorganz/StyLua
