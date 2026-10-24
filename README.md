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

## License and re-use

The code in this dotfile repository is licensed under [the Unlicense](./LICENSE)
(also see [unlicense.org](https://unlicense.org/)).

Feel free to use any code of this repository in your dotfiles!

[NvChad]: https://github.com/NvChad/NvChad
[lazy.nvim]: https://lazy.folke.io/
