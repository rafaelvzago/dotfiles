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
					 ~/.config/alacritty/alacritty.yml \

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
	@mkdir -p ~/.config/alacritty
	@ln -sf $(CURDIR)/alacritty.yml ~/.config/alacritty/alacritty.yml
	@echo "Configure zsh"
	@ln -sf $(CURDIR)/.zshrc ~/.zshrc
	@echo "Configure Vim"
	@ln -sf $(CURDIR)/.vimrc ~/.vimrc
	@vim +PluginInstall +qall
	@echo "Configure Tmux"
	@ln -sf $(CURDIR)/.tmux.conf ~/.tmux.conf
	@~/.tmux/plugins/tpm/bin/install_plugins
	@echo "Configure my.env"
	@ln -sf $(CURDIR)/my.env ~/my.env

# Step to automaticaly add the files to the git repository, commit	with a
git:
	@git add .
	@git status
	@git commit -m "Automatic commit on `date`"
	@git push origin $(shell git rev-parse --abbrev-ref HEAD) || true

