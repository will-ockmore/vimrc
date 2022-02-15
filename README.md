# My vimrc

## Installation

Full install:

```bash
git clone --depth=1 https://github.com/will-ockmore/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

Basic install

```bash
wget https://raw.githubusercontent.com/will-ockmore/vimrc/master/init.vim -o ~/.config/nvim/init.vim
wget https://raw.githubusercontent.com/will-ockmore/vimrc/master/coc-settings.json -o ~/.config/nvim/coc-settings.json
```

## Mac

To enable correct scolling behaviour in iTerm2:

```bash
defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true
```

## Plugins

uses [vim-plug](https://github.com/junegunn/vim-plug)
