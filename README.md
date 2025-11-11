# 🧩 Dotfiles Setup (macOS)

This repository bootstraps your full macOS development environment — including Homebrew, Alacritty, tmux, LazyVim, macOS preferences, and your personal dotfiles.

---

## 🚀 Quickstart (recommended)

Run this single command in a fresh macOS terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/johnchase/dotfiles/main/bootstrap-macos.sh)"
```

✅ This script will:

- Install [Homebrew](https://brew.sh)
- Install CLI tools, fonts, and apps (Alacritty, tmux, fzf, LazyGit, etc.)
- Clone this repo into `~/dotfiles`
- Run **GNU Stow** to symlink your configuration
- Configure macOS defaults (key repeat, tap-to-click, hot corners, etc.)
- Install and load your Caps Lock → Escape LaunchAgent
- Bootstrap tmux and LazyVim

After setup:

- Open `tmux` → press **Ctrl-b + I** to install plugins  
- Open `nvim` once to sync LazyVim plugins  
- Log out/in to apply macOS settings  

---

## 🧰 Manual setup (optional reference)

You can also run steps manually for finer control.

### 1️⃣ Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2️⃣ Install core packages

```bash
brew tap homebrew/cask-fonts
brew install stow tmux neovim fzf zoxide node ripgrep lazygit tree \
             bash bc coreutils gawk gh glab gsed jq nowplaying-cli \
             romkatv/powerlevel10k/powerlevel10k
brew install --cask alacritty font-jetbrains-mono-nerd-font
```

### 3️⃣ Clone and stow dotfiles

```bash
git clone https://github.com/johnchase/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -vt "$HOME" home
stow -vt "$HOME" home-macos
```

### 4️⃣ Install tmux plugin manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
```

Then open tmux and press **Ctrl-b + I** to install plugins.

### 5️⃣ Apply macOS preferences

```bash
bash ~/dotfiles/scripts/macos/setup.sh
```

This sets:

- Faster key repeat & shorter delay  
- Tap-to-click enabled  
- Hidden Finder files visible  
- “Open app confirmation” dialog disabled  
- Hot corners (bottom-left → Mission Control, bottom-right → Desktop)  
- Caps Lock → Escape remap (persistent via LaunchAgent)

---

## 🧩 Project structure

```text
dotfiles/
├── bootstrap-macos.sh           # full automated setup script
├── home/                        # shared configuration
├── home-macos/                  # macOS-specific files (e.g. LaunchAgents)
├── scripts/
│   └── macos/
│       └── setup.sh             # macOS defaults configuration
├── launchagents/                # templates for LaunchAgents
└── README.md
```

---

## ✅ Post-install checks

- `~/Library/LaunchAgents/com.johnchase.caps2esc.plist` should exist  
- Caps Lock now behaves as Escape  
- `tmux` shows your custom status bar  
- `nvim` loads LazyVim with your plugins  
- macOS key repeat and hot corners reflect your preferences  
