export TZ=US/Pacific
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH="/opt/homebrew/bin:$PATH"

alias lv="NVIM_APPNAME=LazyVim nvim"

export PYTHONDONTWRITEBYTECODE=1 

# Paths for Nextflow
export JAVA_HOME="/opt/homebrew/opt/openjdk"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# # Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
#
# source ~/.prompt.zsh
#
#
# export VISUAL=lvim
# export EDITOR="$VISUAL"
#
# alias clock='while true; do tput reset; date +"%H:%M:%S" | figlet -f epic; sleep 1; done'
#
# export PATH="$PATH:$NPM_PACKAGES/bin"
# export PATH="/Users/johnchase/.local/bin:$PATH"
# export PATH="/Users/johnchase/.cargo/bin:$PATH"
#
# NPM_PACKAGES="${HOME}/.npm-packages"
#
#
# export PATH="$PATH:$NPM_PACKAGES/bin"
# export PATH="/Users/johnchase/.local/bin:$PATH"
# export PATH="/Users/johnchase/.cargo/bin:$PATH"
#
#
# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# # Finished adapting your PATH environment variable for use with MacPorts.
#
#
# # MacPorts Installer addition on 2022-03-22_at_15:02:54: adding an appropriate MANPATH variable for use with MacPorts.
# export MANPATH="/opt/local/share/man:$MANPATH"
#
# # Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#

#
#  # Start: Run multiple Neovim distros
# End: Run multiple Neovim distros
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
#
# # Amazon Q post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# Try to find conda installation in common locations
if [ -d "$HOME/miniforge3" ]; then
    CONDA_PATH="$HOME/miniforge3"
elif [ -d "$HOME/anaconda3" ]; then
    CONDA_PATH="$HOME/anaconda3"
elif [ -d "$HOME/miniconda3" ]; then
    CONDA_PATH="$HOME/miniconda3"
elif [ -d "/opt/conda" ]; then
    CONDA_PATH="/opt/conda"
fi

# If conda was found, set it up
if [ -n "$CONDA_PATH" ]; then
    __conda_setup="$('$CONDA_PATH/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
# . "$CONDA_PATH/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
            export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# Clean up
unset CONDA_PATH
# <<< conda initialize <<<
#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fpath+=~/.zfunc; autoload -Uz compinit; compinit

 export PATH="/opt/homebrew/opt/krb5/bin:$PATH"

. "$HOME/.local/bin/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/johnchase/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/johnchase/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/johnchase/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/johnchase/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/johnchase/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/johnchase/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
#
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/johnchase/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
