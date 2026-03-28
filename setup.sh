#!/usr/bin/env bash
echo "Linking ~/.vimrc to vimConfig/.vimrc"
if [ -L ~/.vimrc];then
    echo "Symlink already exists, change manually"
else
    ln -s ~/vimConfig/.vimrc ~/.vimrc
fi
echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Done installing vim-plug"
