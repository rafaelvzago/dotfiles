# This Makefile is used to copy all the dotfiles into their respective folder.
# It also creates a backup of the existing dotfiles.
# Author: Rafael Zago
# Date: 2013-03-10
# Version: 1.0
# License: MIT License
# Usage: make install

# Variables
# The dotfiles to be copied
# The dotfiles to be copied to the home folder (~/) are listed here (without the dot)
BACKUP_FOLDER = ~/Git/dotfiles/
DOTFILES = ~/my.env ~/.vimrc ~/.zshrc ~/.tmux.conf ~/.config/alacritty/alacritty.yml

# Step to check if the dofiles already exist
check:
	@for dotfile in $(DOTFILES); do \
		if [ -e $$dotfile ]; then \
			echo "The file $$dotfile already exists."; \
		fi; \
	done

# Step to backup the existing dotfiles, copying from the original location to the backup folder.
backup:
	@for dotfile in $(DOTFILES); do \
		if [ -e $$dotfile ]; then \
			echo "Backing up $$dotfile to $(BACKUP_FOLDER)"; \
			cp -r $$dotfile $(BACKUP_FOLDER); \
		fi; \
	done

