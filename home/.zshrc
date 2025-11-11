#### Basic environment #########################################################

export TZ=US/Pacific

#### Powerlevel10k instant prompt (must stay at top) ###########################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
fi

#### Homebrew ##################################################################

if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

#### Zinit #####################################################################

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

#### Prompt / Powerlevel10k ####################################################

# Load Powerlevel10k theme if installed via Homebrew
if command -v brew >/dev/null 2>&1; then
  P10K_THEME="$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
  if [[ -r "$P10K_THEME" ]]; then
    source "$P10K_THEME"
  fi
fi

# Load user Powerlevel10k config if present
if [[ -r "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

#### Zinit plugins #############################################################

# Core plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh My Zsh plugin snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

#### Completions / fpath #######################################################

# Docker completions (if present)
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

# Custom function path
fpath=("$HOME/.zfunc" $fpath)

autoload -Uz compinit
compinit

# Replay compdefs defined by plugins/snippets
zinit cdreplay -q

#### History ###################################################################

HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#### Keybindings ###############################################################

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

#### Aliases ###################################################################

alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias lv='NVIM_APPNAME=LazyVim nvim'

#### Tools / Integrations ######################################################

# fzf integration (only if installed)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# zoxide integration (only if installed)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

#### PATH ######################################################################

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Nextflow / Java (if installed)
if [[ -d "/opt/homebrew/opt/openjdk" ]]; then
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# krb5 (if installed)
if [[ -d "/opt/homebrew/opt/krb5/bin" ]]; then
  export PATH="/opt/homebrew/opt/krb5/bin:$PATH"
fi

export PYTHONDONTWRITEBYTECODE=1

#### Optional local env ########################################################

if [[ -r "$HOME/.local/bin/env" ]]; then
  . "$HOME/.local/bin/env"
fi

#### Conda / Mamba #############################################################

if [[ -x "$HOME/miniforge3/bin/conda" ]]; then
  __conda_setup="$("$HOME/miniforge3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  else
    if [[ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]]; then
      . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/miniforge3/bin:$PATH"
    fi
  fi
  unset __conda_setup
fi

if [[ -x "$HOME/miniforge3/bin/mamba" ]]; then
  export MAMBA_EXE="$HOME/miniforge3/bin/mamba"
  export MAMBA_ROOT_PREFIX="$HOME/miniforge3"
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__mamba_setup"
  else
    alias mamba="$MAMBA_EXE"
  fi
  unset __mamba_setup
fi

#### End #######################################################################
