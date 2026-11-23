#!/usr/bin/env bash
set -euo pipefail

### dotfiles bootstrap for macOS
### - Installs Homebrew (if missing)
### - Installs core CLI + GUI tools
### - Clones dotfiles repo (if needed)
### - Stows shared + LazyVim + macOS-specific configs
### - Installs tmux plugin manager (TPM)
### - Preps lazygit config dir
### - Runs macOS defaults script (if present)

REPO_URL="https://github.com/johnchase/dotfiles.git"
REPO_DIR="$HOME/dotfiles"

is_macos() {
  [[ "${OSTYPE:-}" == darwin* ]]
}

log() {
  printf "\033[1;32m==>\033[0m %s\n" "$*"
}

warn() {
  printf "\033[1;33m[warn]\033[0m %s\n" "$*"
}

cleanup_legacy_lazyvim_links() {
  local legacy_links=(
    "$HOME/.neoconf.json"
    "$HOME/after"
    "$HOME/init.lua"
    "$HOME/lazy-lock.json"
    "$HOME/lazyvim.json"
    "$HOME/lua"
    "$HOME/stylua.toml"
  )

  local link=""
  local target=""
  for link in "${legacy_links[@]}"; do
    if [[ -L "$link" ]]; then
      target="$(readlink "$link" || true)"
      if [[ "$target" == .config/LazyVim/* ]]; then
        log "Removing legacy LazyVim link: $link -> $target"
        rm "$link"
      fi
    fi
  done
}

### 1. OS check #################################################################

if ! is_macos; then
  echo "This bootstrap script is intended for macOS." >&2
  exit 1
fi

### 2. Install Homebrew if missing #############################################

ensure_brew() {
  if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
    return 0
  fi
  for path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$path" ]]; then
      eval "$("$path" shellenv)"
      return 0
    fi
  done
  return 1
}

# Install if missing
if ! command -v brew >/dev/null 2>&1; then
  log "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! ensure_brew; then
  warn "Unable to find Homebrew after installation; please check your PATH."
  exit 1
fi

### 3. Install core packages ####################################################

log "Installing core packages via Homebrew..."

brew install -q \
  stow \
  tmux \
  neovim \
  bash \
  bc \
  coreutils \
  gawk \
  gh \
  glab \
  gsed \
  jq \
  nowplaying-cli \
  fzf \
  zoxide \
  node \
  ripgrep \
  lazygit \
  tree \
  uv \
  romkatv/powerlevel10k/powerlevel10k

brew install --cask -q \
  alacritty \
  font-jetbrains-mono-nerd-font

log "Core packages installed."

### 4. Clone dotfiles repo ######################################################

if [[ -d "$REPO_DIR/.git" ]]; then
  log "dotfiles repo already present at $REPO_DIR."
else
  log "Cloning dotfiles repo into $REPO_DIR..."
  git clone "$REPO_URL" "$REPO_DIR"
fi

# --- Ensure origin is set to SSH ---
log "Setting remote origin to SSH (git@github.com:johnchase/dotfiles.git)"
git -C "$REPO_DIR" remote set-url origin git@github.com:johnchase/dotfiles.git || true

cd "$REPO_DIR"

### 5. Stow shared + LazyVim + macOS-specific configs ############################

cleanup_legacy_lazyvim_links

LAZYVIM_DIR="$HOME/.config/LazyVim"

if [[ -L "$LAZYVIM_DIR" && ! -e "$LAZYVIM_DIR" ]]; then
  warn "Removing broken LazyVim symlink at $LAZYVIM_DIR."
  rm "$LAZYVIM_DIR"
fi

if [[ -e "$LAZYVIM_DIR" && ! -L "$LAZYVIM_DIR" ]]; then
  backup="$LAZYVIM_DIR.pre-dotfiles.$(date +%Y%m%d%H%M%S)"
  warn "Found existing non-symlink LazyVim config. Moving to $backup"
  mv "$LAZYVIM_DIR" "$backup"
fi

log "Stowing dotfiles (shared shell + terminal + tmux)..."
stow -vt "$HOME" home

if [[ -d "$REPO_DIR/lazyvim" ]]; then
  log "Stowing LazyVim config..."
  stow -vt "$HOME" lazyvim
else
  warn "lazyvim package not found at $REPO_DIR/lazyvim (skipping)."
fi

if [[ -d "$REPO_DIR/home-macos" ]]; then
  log "Stowing macOS-specific dotfiles..."
  stow -vt "$HOME" home-macos
fi

### 6. Ensure LaunchAgents directory is sane ####################################

# Important: make sure LaunchAgents is a directory, not a symlink
if [[ -L "$HOME/Library/LaunchAgents" ]]; then
  warn "~/Library/LaunchAgents was a symlink. Fixing it."
  rm "$HOME/Library/LaunchAgents"
fi
mkdir -p "$HOME/Library/LaunchAgents"

# If caps2esc plist exists via stow, validate it
if [[ -f "$HOME/Library/LaunchAgents/com.johnchase.caps2esc.plist" ]]; then
  if plutil -lint "$HOME/Library/LaunchAgents/com.johnchase.caps2esc.plist" >/dev/null 2>&1; then
    log "Loading Caps Lock -> Esc LaunchAgent..."
    launchctl bootstrap "gui/$UID" "$HOME/Library/LaunchAgents/com.johnchase.caps2esc.plist" 2>/dev/null ||
      launchctl load "$HOME/Library/LaunchAgents/com.johnchase.caps2esc.plist" ||
      warn "Could not load com.johnchase.caps2esc LaunchAgent (you can investigate with launchctl later)."
  else
    warn "com.johnchase.caps2esc.plist is invalid; not loading."
  fi
fi

### 7. Verify LazyVim config ####################################################

if [[ -f "$LAZYVIM_DIR/init.lua" ]]; then
  log "LazyVim config is active at $LAZYVIM_DIR."
else
  warn "LazyVim config not found at $LAZYVIM_DIR."
fi

### 8. Tmux plugin manager (TPM) ###############################################

if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
  log "Tmux Plugin Manager (TPM) already installed."
else
  log "Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "To install tmux plugins, open tmux and press: Ctrl-b + I"

### 9. Lazygit config bootstrap #################################################

LAZYGIT_DIR="$HOME/Library/Application Support/lazygit"
mkdir -p "$LAZYGIT_DIR"

if [[ ! -f "$LAZYGIT_DIR/config.yml" ]]; then
  : >"$LAZYGIT_DIR/config.yml"
  log "Created empty LazyGit config at '$LAZYGIT_DIR/config.yml'."
else
  log "LazyGit config already exists at '$LAZYGIT_DIR/config.yml'."
fi

### 10. macOS defaults (key repeat, tap-to-click, etc.) #########################

MAC_SETUP="$REPO_DIR/scripts/macos/setup.sh"
if [[ -x "$MAC_SETUP" ]]; then
  log "Running macOS setup script..."
  bash "$MAC_SETUP"
else
  warn "macOS setup script not found or not executable at $MAC_SETUP (skipping)."
fi

log "Bootstrap complete."
echo
echo "Notes:"
echo "  - Open tmux and press Ctrl-b + I to install tmux plugins."
echo "  - Open LazyVim once: NVIM_APPNAME=LazyVim nvim"
echo "  - Some macOS settings may require log out / log in to fully apply."
