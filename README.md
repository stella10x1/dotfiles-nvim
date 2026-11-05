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

Lua files are formatted with [StyLua][StyLua] (config in `.stylua.toml`). A
[pre-commit][pre-commit] hook runs it on every commit:

```bash
# install the git hook once per clone
pre-commit install

# optionally format all files
pre-commit run --all-files
```

If the hook reformats files, the commit is aborted. Review the changes, stage
them and commit again.

## License and re-use

The code in this dotfile repository is licensed under [the Unlicense](./LICENSE)
(also see [unlicense.org](https://unlicense.org/)).

Feel free to use any code of this repository in your dotfiles!

[NvChad]: https://github.com/NvChad/NvChad
[lazy.nvim]: https://lazy.folke.io/
[pre-commit]: https://pre-commit.com/
[StyLua]: https://github.com/JohnnyMorganz/StyLua
