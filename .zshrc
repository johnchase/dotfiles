# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set zshell package manager zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
zinit ice depth=1; zinit light romkatv/powerlevel10k










# # Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
#
# source ~/.prompt.zsh
#
# export TZ=US/Pacific
#
# export VISUAL=lvim
# export EDITOR="$VISUAL"
# export PYTHONDONTWRITEBYTECODE=1 
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

export PATH="/opt/homebrew/bin:$PATH"
#
#  # Start: Run multiple Neovim distros
alias av="NVIM_APPNAME=AstroNvim nvim"
alias chad="NVIM_APPNAME=NvChad nvim"
alias lv="NVIM_APPNAME=LazyVim nvim"

 function nvims() {
  items=("default" "AstroNvim" "NvChad", "LazyVim")
   config=$(printf "%s\n" "${items[@]}" | fzf --prompt="  Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
   if [[ -z $config ]]; then
     echo "Nothing selected"
     return 0
   elif [[ $config == "default" ]]; then
     config=""
   fi
   NVIM_APPNAME=$config nvim $@
 }
# End: Run multiple Neovim distros
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
#
# # Amazon Q post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
#
# alias ca="conda deactivate; conda activate"
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/johnchase/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/johnchase/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/johnchase/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/johnchase/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
