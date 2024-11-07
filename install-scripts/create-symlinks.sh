#!/bin/zsh
# Inspired from https://github.com/mattjmorrison/dotfiles/blob/master/install-scripts/Linux/create-symlinks.sh
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/dotfiles/
#
#===============================================================================

#==============
# Variables
#==============
dotfiles_dir=~/dotfiles

#==============
# Rename existing dot files and folders (append .old)
#==============
for name in ~/.bashrc ~/.zshrc; do
    if [ -e "$name" ]; then
        mv "$name" "$name.old" 2>/dev/null
    fi
done

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -sf $dotfiles_dir/bash/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc