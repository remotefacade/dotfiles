#!/bin/bash
############################
# Credit to https://github.com/michaeljsmalley/dotfiles
# This script creates symlinks from the home directory 
# to any desired dotfiles in ~/dotfiles
############################

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/dotfiles_old

# list of files/folders to symlink in homedir
files="bashrc profile alias env"

# neovim kickstart directory
kickstartdir=~/.config/nvim

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks from the homedir to any files in the ~/dotfiles 
# directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/

    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_nvim () {
    # Clone my neovim kickstart repository from GitHub only if it isn't already present
    if [[ ! -d $kickstartdir ]]; then
        echo "Cloning neovim kickstart to ${kickstartdir}..."
        git clone https://github.com/remotefacade/kickstart.nvim
      else
        echo "Looks like we've already cloned NeoVim kickstart to ${kickstartdir}, nice!"
    fi

    # Test to see if neovim is installed. If it is:
    if [ -f /bin/nvim -o -f /usr/bin/nvim ]; then
        echo "NeoVim is already installed!"
       else
        # Bindly assume we're using openSUSE, this should be replaced
        # with a better distro/package manager check.
        echo "NeoVim isn't installed, let's install it..."
        sudo zypper install neovim python-neovim python3-neovim
    fi
}

install_nvim

