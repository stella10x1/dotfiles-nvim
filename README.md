# Dotfiles Neovim

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
