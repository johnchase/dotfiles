# dotfiles

## Install Alacritty

```bash
brew install --cask alacritty

```

## Clone this repository to your home directory

```bash
git clone https://github.com/johnchase/dotfiles.git
```

## Run stow to sync the dotfiles

```bash
cd dotfiles
stow *
```

This will stow everything, i.e. overwrite any existing dotfiles. If you want to stow individual directories, you can do so by running `stow <directory>`. For example, `stow nvim` will only stow the nvim directory.

## Install LazyVim into the correct location

This likely doesn't need to be done

```bash
brew install nvim
git clone https://github.com/LazyVim/starter ~/.config/LazyVim
rm -rf ~/.config/LazyVim/.git
```

## Install dependencies for tmux UI

### OSX instructions

OSX ships with bash 3.2, which will not work with the default tmux theme.

```bash
brew install --cask font-monaspace-nerd-font font-noto-sans-symbols-2 brew tap homebrew/cask font-iosevka
brew install --cask font-jetbrains-mono-nerd-font
brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli
brew install fzf
brew install zoxide
```

If needed install tmux plugins. Open tmux and run <leader>I
Tmux is configured to use .tmux/plugins for plugin management, If you run into issues install tmp

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Need to install a bbunch of stuff

brew install node
brew install ripgrep
brew install lazygit

MasonInstall python toml etc
Install mini surround through extras

for lazygit

# create the expected directory

mkdir -p ~/Library/Application\ Support/lazygit

# create a config file (empty is fine to start)

:> ~/Library/Application\ Support/lazygit/config.yml

# optional: populate it with the default template LazyGit prints

lazygit --config > ~/Library/Application\ Support/lazygit/config.yml
