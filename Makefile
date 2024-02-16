# This Makefile is used to copy all the dotfiles into their respective folder.
# It also creates a backup of the existing dotfiles.
# Author: Rafael Zago
# Date: 2013-03-10
# Version: 1.0
# License: MIT License
# Usage: make install

# Variables
# Backup folder
BACKUP_FOLDER = $(CURDIR)
USER = $(shell whoami)
# Dotfiles to be copied
DOTFILES = ~/.p10k.zsh	\
					 ~/my.env			\
					 ~/.vimrc			\
					 ~/.zshrc			\
					 ~/.bashrc		\
					 ~/.tmux.conf \
					 ~/.config/alacritty/alacritty.toml \
					 ~/.config/lvim/config.lua

# Step to check if the dofiles already exist
check:
	@for dotfile in $(DOTFILES); do \
		if [ -e $$dotfile ]; then \
			echo "The file $$dotfile already exists."; \
		else echo "The file $$dotfile doesn't exist."; \
		fi; \
	done

# Step to update the dotfiles, creating the symbolic links to the dotfiles.
config:
	@echo "Configure Alacritty"
	@mkdir -p ~/.config/alacritty || true
	@ln -s $(CURDIR)/alacritty.toml ~/.config/alacritty/alacritty.toml || true
	@echo "Configure Bash"
	@ln -s $(CURDIR)/.bashrc ~/.bashrc || true
	@echo "Configure Vim"
	@ln -s $(CURDIR)/.vimrc ~/.vimrc || true
	@vim +PluginInstall +qall || true
	@echo "Configure Tmux"
	@ln -s $(CURDIR)/.tmux.conf ~/.tmux.conf || true
	@~/.tmux/plugins/tpm/bin/install_plugins || true
	@echo "Configure my.env"
	@ln -s $(CURDIR)/my.env ~/my.env || true
	@echo "Configure lvim"
	@mkdir -p ~/.config/lvim || true
	@ln -s $(CURDIR)/config.lua ~/.config/lvim/config.lua || true

# Step to automaticaly add the files to the git repository, commit	with a
git:
	@git add .
	@git status
	@git commit -m "Automatic commit on `date`"
	@git push origin $(shell git rev-parse --abbrev-ref HEAD) || true

