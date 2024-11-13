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
# Check which softs are installed
#==============
terminator_installed=false
tmux_installed=false
vim_installed=false

if command -v vim > /dev/null; then
    vim_installed=true
else
    echo "Warning: 'vim' is not installed. Skipping related tasks."
fi

if command -v terminator > /dev/null; then
    terminator_installed=true
else
    echo "Warning: 'terminator' is not installed. Skipping related tasks."
fi

if command -v tmux > /dev/null; then
    tmux_installed=true
else
    echo "Warning: 'tmux' is not installed. Skipping related tasks."
fi

#==============
# Rename existing dot files and folders (append .old)
#==============
for name in ~/.bashrc ~/.zshrc; do
    if [ -e "$name" ]; then
        mv "$name" "$name.old" 2>/dev/null
    fi
done

# Rename vim config if terminator is installed
if $vim_installed; then
    if [ -e ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.old 2>/dev/null
    fi
fi

# Rename terminator config if terminator is installed
if $terminator_installed; then
    if [ -e ~/.config/terminator/config ]; then
        mv ~/.config/terminator/config ~/.config/terminator/config.old 2>/dev/null
    fi
fi

# Rename tmux config if tmux is installed
if $tmux_installed; then
    if [ -e ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.old 2>/dev/null
    fi
fi

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -sf $dotfiles_dir/bash/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc

# Create symlink for vim config if vim is installed
if $vim_installed; then
    ln -sf $dotfiles_dir/vim/.vimrc ~/.vimrc
fi

# Create symlink for terminator config if terminator is installed
if $terminator_installed; then
    mkdir -p ~/.config/terminator  # Ensure the directory exists
    ln -sf $dotfiles_dir/custom/terminator/config ~/.config/terminator/config
fi

# Create symlink for tmux config if tmux is installed
if $tmux_installed; then
    ln -sf $dotfiles_dir/tmux/.tmux.conf ~/.tmux.conf
fi
