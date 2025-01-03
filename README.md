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
stow */
```

This will stow everything, i.e. overwrite any existing dotfiles. If you want to stow individual directories, you can do so by running `stow <directory>`. For example, `stow nvim` will only stow the nvim directory.

## Install LazyVim into the correct location

```bash
git clone https://github.com/LazyVim/starter ~/.config/LazyVim
rm -rf ~/.config/LazyVim/.git
```
