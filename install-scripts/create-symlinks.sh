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
zsh_installed=false
vim_installed=false
terminator_installed=false
tmux_installed=false

# Check if zsh is installed
if command -v zsh > /dev/null; then
    zsh_installed=true
    # if oh-my-zsh is not installed
    if ! [ -d "$HOME/.oh-my-zsh" ]; then
        # Install oh-my-zsh
        echo "Installing 'oh-my-zsh'"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s --batch || {
            echo "Could not install Oh My Zsh"
            exit 1
        }
    fi
else
    echo "Warning: 'zsh' is not installed. Skipping related tasks."
fi

# Check if vim is installed
if command -v vim > /dev/null; then
    vim_installed=true
else
    echo "Warning: 'vim' is not installed. Skipping related tasks."
fi

# Check if terminator is installed
if command -v terminator > /dev/null; then
    terminator_installed=true
else
    echo "Warning: 'terminator' is not installed. Skipping related tasks."
fi

# Check if tmux is installed
if command -v tmux > /dev/null; then
    tmux_installed=true
else
    echo "Warning: 'tmux' is not installed. Skipping related tasks."
fi

#==============
# Rename existing dot files and folders (append .old)
#==============
for name in ~/.bashrc ~/.zshrc ~/.vimrc ~/.config/terminator/config ~/.tmux.conf; do
    if [ -e "$name" ]; then
        mv "$name" "$name.old" 2>/dev/null
    fi
done

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============

# Create symlink for bash config
ln -sf $dotfiles_dir/bash/.bashrc ~/.bashrc

# Create symlink for zsh config if zsh is installed
if $zsh_installed; then
    ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc
fi

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
