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
git clone https://github.com/LazyVim/starter ~/.config/LazyVim
rm -rf ~/.config/LazyVim/.git
```

## Install dependencies for tmux UI

### OSX instructions

OSX ships with bash 3.2, which will not work with the default tmux theme.

```bash
brew install --cask font-monaspace-nerd-font font-noto-sans-symbols-2 brew tap homebrew/cask font-iosevka
brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli
```

If needed install tmux plugins. Open tmux and run <leader>I
Tmux is configured to use .tmux/plugins for plugin management, If you run into issues install tmp

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
