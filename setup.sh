#!/bin/bash

# move dotfiles to a backup directory if they already exist
mkdir ~/dotfiles_backup
mv ~/.bashrc ~/dotfiles_backup/.bashrc
mv ~/.emacs ~/dotfiles_backup/.emacs
mv ~/.emacs.d ~/dotfiles_backup/.emacs.d
mv ~/.gvimrc ~/dotfiles_backup/.gvimrc
mv ~/.hgrc ~/dotfiles_backup/.hgrc
mv ~/.hgignore ~/dotfiles_backup/.hgignore
mv ~/.jartps1.sh ~/dotfiles_backup/.jartps1.sh
mv ~/.tmux.conf ~/dotfiles_backup/.tmux.conf
mv ~/.vim ~/dotfiles_backup/.vim
mv ~/.vimrc ~/dotfiles_backup/.vimrc

# setup the home directories dotfiles to point here
ln -s $(pwd)/.bashrc ~/.bashrc
ln -s $(pwd)/.emacs ~/.emacs
ln -s $(pwd)/.emacs.d ~/.emacs.d
ln -s $(pwd)/.gvimrc ~/.gvimrc
ln -s $(pwd)/.hgrc ~/.gvimrc
ln -s $(pwd)/.hgignore ~/.hgignore
ln -s $(pwd)/.jartps1.sh ~/.jartps1.sh
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.vim ~/.vim
ln -s $(pwd)/.vimrc ~/.vimrc

