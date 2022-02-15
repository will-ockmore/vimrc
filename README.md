# My vimrc

Assumes use of [neovim](https://neovim.io/)

## Installation

```bash
wget https://raw.githubusercontent.com/will-ockmore/vimrc/master/init.vim -o ~/.config/nvim/init.vim
wget https://raw.githubusercontent.com/will-ockmore/vimrc/master/coc-settings.json -o ~/.config/nvim/coc-settings.json
```

On startup, plugins will be installed and treesitter modules will be compiled.

## Mac

To enable correct scolling behaviour in iTerm2:

```bash
defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true
```

## Plugins

Uses [vim-plug](https://github.com/junegunn/vim-plug). See the `Plugins` section for included plugins.
