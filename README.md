# Automated macOS workstation set up

## Features

- Install Homebrew
- Install CLI and GUI packages
- Change system settings
- Install [my dotfiles](https://github.com/khuedoan/dotfiles)

## Usage

```sh
xcode-select --install

SRCDIR="$HOME/.local/src/macos-setup"

git clone https://github.com/khuedoan/macos-setup "$SRCDIR"
cd "$SRCDIR"

make
```
