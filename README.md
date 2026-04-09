# vim
vimrc with plugins, keymaps and other settings
# Environment setup
* Export an environment variable
```
export VIMINIT="~/vimConfig/.vimrc"
```
# VimPlug
```
https://github.com/junegunn/vim-plug
```
# YouCompleteMe
    * Has system dependencies that need to be installed prior to use
    * The ./install.py script must be run to setup the different engines
# Ultisnips
* Collection of ultisnips for inspiration: https://github.com/honza/vim-snippets/tree/master/UltiSnips
# ALE
* Ruff Download
* Flake8 Download
# Ctags
* Point ctags config file to the one in this folder
```
mkdir ~/.ctags.d/
ln -s ~/vimConfig/default.ctags ~/.ctags.d/default.ctags
```
