# My configuration for nvim

Can't be bothered to learn VimScript.

# Installation

Make sure the directory *$HOME/.config/nvim* **doesn't** exist.

```bash
git clone https://github.com/einyakamnil/nvim-config
```

```bash
ln --symbolic $(pwd)/nvim-config $HOME/.config/nvim
```

# Features

+ Only use 'cindent' for indenting for all filetypes
+ Custom 'foldexpr' for most file types
+ Comment toggling via <C-c> (Normal- and Visual-Mode)
+ Shows frequently used registers when trying to select from one

# Colorscheme

Blue and purple.

# TODO

+ add custom indentation rules
+ ctags support
