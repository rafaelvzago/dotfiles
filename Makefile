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
BACKUP_FOLDER = $(CURDIR)
DOTFILES = ~/.p10k.zsh ~/my.env ~/.vimrc ~/.zshrc ~/.tmux.conf ~/.config/alacritty/alacritty.yml

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

# Step to config the machine when it's new, installing the dependencies to:
# - Vim
#   - Vundle
#   - Plugins
#   - Colorscheme
# - Tmux
#   - Tmux Plugin Manager
# - Zsh
# - Powerlevel10k
# - Alacritty
new-machine:
	@echo "Installing dependencies"
	@echo "Installing Vundle"
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true # Ignore if already exists
	@echo "Installing Vim plugins"
	@vim +PluginInstall +qall || true # Ignore if already exists
	@echo "Installing Tmux Plugin Manager" 
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true # Ignore if already exists
	@echo "Installing Powerlevel10k"
	@git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k || true # Ignore if already exists
	@echo "Configure allacritty Alacritty"
	@mkdir -p ~/.config/alacritty
	@ln -s $(CURDIR)/alacritty.yml ~/.config/alacritty/alacritty.yml || true # Ignore if already exists

# Step to automaticaly add the files to the git repository, commit	with a default message
# and push to the remote repository. The message is the current date, the git status output.
# The commit is only done if there are changes to be commited.
git:
	@echo "Commiting changes to git repository"
	@git add .
	@git commit -m "`date`" -m "`git status --porcelain` "
	@echo "Pushing changes to git repository"
	@git push
