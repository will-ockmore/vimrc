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

## Screenshots

Including tmux configuration:


![Screenshot from 2022-02-15 14-50-54](https://user-images.githubusercontent.com/13736156/154086503-dd134ed9-de43-4237-a870-4486bbdf979f.png)
