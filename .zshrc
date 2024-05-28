# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH
# Set the dictionary to store zinit and it's plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Check the zinit home directory
if [ ! -d "$ZINIT_HOME" ]; then
  git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Adding Powerlevel10k
zinit ice --depth=1; zinit light romkatv/powerlevel10k # Powerlevel10k

# Adding Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Adding snippets
zinit snippet OMZP::git # Git aliases
zinit snippet OMZP::kubectl # Kubectl aliases
zinit snippet OMZP::kubectx # Kubectl context aliases
zinit snippet OMZP::aws # AWS aliases
zinit snippet OMZP::python # Python aliases
zinit snippet OMZP::ansible # Ansible aliases
zinit snippet OMZP::azure # Azure aliases
zinit snippet OMZP::oc # OpenShift aliases
zinit snippet OMZP::podman # Podman aliases

# Plugins configuration
autoload -U compinit && compinit  # Load zsh autocomplete
zinit cdreplay -q # Load cdreplay

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Key bindings
bindkey -e # Use emacs key bindings
bindkey '^p' history-beginning-search-backward # Search history backward with Ctrl+P
bindkey '^n' history-beginning-search-forward # Search history forward with Ctrl+N

# History
HISTSIZE=10000 # Number of lines to keep in memory
HISTFILE=~/zsh_history # File to save history
SAVEHIST=$HISTSIZE # Number of lines to save in history file
HISTDUP=erase 
setopt appendhistory # Append history to file
setopt sharehistory # Share history between sessions
setopt hist_ignore_space # Ignore commands starting with space
setopt hist_ignore_dups # Ignore duplicate commands
setopt hist_save_no_dups # Don't save duplicate commands
setopt hist_ignore_all_dups # Ignore all duplicate commands
setopt hist_find_no_dups # Don't display duplicate commands

# Completion style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Color completion
zstyle ':completion:*' menu no # Disable completion menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # FZF preview for cd

# Aliases
alias ls='ls --color=auto'

# Shell integrationd
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rzago/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rzago/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rzago/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rzago/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# System configuration
eval "$(ssh-agent -s)" > /dev/null 2>&1 # Start ssh-agent

# Load custom scripts

source $HOME/my.env