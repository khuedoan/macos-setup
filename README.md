# Automated macOS workstation set up

## Features

- Install [Nix](https://nixos.org/download.html#nix-install-macos), [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager) and [Homebrew](https://brew.sh)
- Install CLI and GUI apps
- Change system settings
- Install [my dotfiles](https://github.com/khuedoan/dotfiles)

## Usage

```sh
git clone https://github.com/khuedoan/macos-setup macos-setup
cd macos-setup
make
```

Then reboot.

## Acknowledgements

- [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
