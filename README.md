# My vimrc

Forked from [the ultimate vimrc](https://github.com/amix/vimrc), but removing several plugins and customizing.

Main changes:

- Swap [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) for [fzf](https://github.com/junegunn/fzf) (optionally using [rg](https://github.com/BurntSushi/ripgrep)) for faster and easier file / buffer search
- Change colorscheme to gruvbox
- Add [coc.nvim](https://github.com/neoclide/coc.nvim) for autocompletion and LSP support (VSCode-like IDE behaviour)

## Installation

Full install:

```bash
git clone --depth=1 https://github.com/will-ockmore/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

Basic install

```bash
git clone --depth=1 https://github.com/will-ockmore/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
```

## Mac

To enable correct scolling behaviour in iTerm2:

```bash
defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true
```

## Updating plugins

Update the plugin list in `update_plugins.py` and run it (requires `pip install requests` if not already available). If deleting plugins, remove them from `sources_non_forked`
