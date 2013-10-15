#!/bin/bash

# move dotfiles to a backup directory if they already exist
mkdir ~/dotfiles_backup
mv ~/.emacs ~/dotfiles_backup/.emacs
mv ~/.emacs.d ~/dotfiles_backup/.emacs.d
mv ~/.vim ~/dotfiles_backup/.vim
mv ~/.vimrc ~/dotfiles_backup/.vimrc
mv ~/.gvimrc ~/dotfiles_backup/.gvimrc

# setup the home directories dotfiles to point here
ln -s $(pwd)/.emacs ~/.emacs
ln -s $(pwd)/.emacs.d ~/.emacs.d
ln -s $(pwd)/.vim ~/.vim
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.gvimrc ~/.gvimrc
