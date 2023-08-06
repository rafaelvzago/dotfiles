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
# Dotfiles to be copied
DOTFILES = ~/.p10k.zsh	\
					 ~/my.env			\
					 ~/.vimrc			\
					 ~/.zshrc			\
					 ~/.tmux.conf \
					 ~/.config/alacritty/alacritty.yml

# Step to check if the dofiles already exist
check:
	@for dotfile in $(DOTFILES); do \
		if [ -e $$dotfile ]; then \
			echo "The file $$dotfile already exists."; \
		fi; \
	done

# Step to backup the existing dotfiles, copying from the original location to 
# the backup folder.
backup:
	@for dotfile in $(DOTFILES); do \
		if [ -e $$dotfile ]; then \
			echo "Backing up $$dotfile to $(BACKUP_FOLDER)"; \
			cp -r $$dotfile $(BACKUP_FOLDER); \
		fi; \
	done

# Step to config the machine when it's new, installing the dependencies to:
new-machine:
	@echo "Configuring a new machine"
	@echo "Setting current user to allow ALL with sudo"
	@echo "$(shell whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
	@echo "Installing Vundle"
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true 
	@echo "Installing Vim plugins"
	@vim +PluginInstall +qall || true 
	@echo "Installing Tmux Plugin Manager" 
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true 
	@echo "Installing Powerlevel10k"
	@git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k || true 
	@echo "Installing Openshift CLI with SUDO"
	@sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -o /usr/local/bin/oc.tar.gz || true
	@echo "Installing Openstack CLI with SUDO"
	@sudo curl -L https://releases.openstack.org/$(shell curl -s https://releases.openstack.org/ | grep -oP '(?<=href=")[^"]*(?=")' | grep -m 1 -oP '(?<=/)[^/]*(?=/")')/openstack-$(shell curl -s https://releases.openstack.org/ | grep -oP '(?<=href=")[^"]*(?=")' | grep -m 1 -oP '(?<=/)[^/]*(?=/")')-$(shell curl -s https://releases.openstack.org/ | grep -oP '(?<=href=")[^"]*(?=")' | grep -m 1 -oP '(?<=/)[^/]*(?=/")')-$(shell curl -s https://releases.openstack.org/ | grep -oP '(?<=href=")[^"]*(?=")' | grep -m 1 -oP '(?<=/)[^/]*(?=/")').tar.gz -o /usr/local/bin/openstack.tar.gz || true

# Step to update the dotfiles, creating the symbolic links to the dotfiles.
update:
	@echo "Configure Alacritty"
	@mkdir -p ~/.config/alacritty || true
	@rm -f ~/.config/alacritty/alacritty.yml
	@ln -s $(CURDIR)/alacritty.yml ~/.config/alacritty/alacritty.yml
	@echo "Configure Zsh"
	@rm -f ~/.zshrc
	@ln -s $(CURDIR)/.zshrc ~/.zshrc
	@echo "Configure Vim"
	@rm -f ~/.vimrc
	@ln -s $(CURDIR)/.vimrc ~/.vimrc
	@echo "Configure Tmux"
	@rm -f ~/.tmux.conf
	@ln -s $(CURDIR)/.tmux.conf ~/.tmux.conf
	@echo "Configure Powerlevel10k"
	@rm -f ~/.p10k.zsh
	@ln -s $(CURDIR)/.p10k.zsh ~/.p10k.zsh
	@echo "Configure my.env"
	@rm -f ~/my.env
	@ln -s $(CURDIR)/my.env ~/my.env

# Step to automaticaly add the files to the git repository, commit	with a 
# default message and push to the remote repository. The message is the current 
# date, the git status output.
# The commit is only done if there are changes to be commited.
# The push will be done even if the destination is not the main branch 
# and doesn't exist in the remote repository.
git:
	@git add .
	@git status
	@git commit -m "Automatic commit on `date`"
	@git push origin $(shell git rev-parse --abbrev-ref HEAD) || true 

