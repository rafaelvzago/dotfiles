#!/bin/bash
# Author: Rafael Zago
# Email: rafaelvzago@gmail.com
# GitHub: https://github.com/rafaelvzago
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# Define paths and files as variables for easy modification and readability
P10K_INSTANT_PROMPT="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
P10K_THEME="$HOME/powerlevel10k/powerlevel10k.zsh-theme"
P10K_CONFIG="$HOME/.p10k.zsh"
OC_BINARY="/usr/local/bin/oc"

# Enable Powerlevel10k instant prompt.
if [[ -r "$P10K_INSTANT_PROMPT" ]]; then
  source "$P10K_INSTANT_PROMPT"
fi

# Initialize completion system
autoload -Uz compinit && compinit

# Load Powerlevel10k theme
source "$P10K_THEME"

# Load Powerlevel10k configuration if it exists
[[ -f "$P10K_CONFIG" ]] && source "$P10K_CONFIG"

# FZF configuration with ripgrep as the default command
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi


# OpenShift 'oc' completion
if [ -f "$OC_BINARY" ]; then
  source <(oc completion zsh)
  compdef _oc oc
fi

# Load custom environment variables
source "$HOME/my.env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rzago/google-cloud-sdk/path.zsh.inc' ]; then . '/home/rzago/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rzago/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/rzago/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
