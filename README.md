# Automated macOS workstation set up

## Features

- Install [Nix](https://nixos.org/download.html#nix-install-macos), [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager) and [Homebrew](https://brew.sh)
- Install CLI and GUI apps
- Change system settings
- Install [my dotfiles](https://github.com/khuedoan/dotfiles)

## Usage

- Change the hostname and username in `./flake.nix` and `./hosts/*.nix`
- Go to **Settings -> Security & Privacy -> Privacy -> Full Disk Access** and allow the Terminal app

```sh
git clone https://github.com/khuedoan/macos-setup macos-setup
cd macos-setup
make
```

Then reboot.

## Testing

1. Install [UTM](https://getutm.app)
2. Download [macOS IPSW recovery file](https://ipsw.me/product/Mac)
3. Create a macOS VM in UTM using the downloaded IPSW file
4. Run `xcode-select --install` in the new VM
5. (Optional) Clone the VM to a new one for easy rollback ([UTM doesn't support snapshot yet](https://github.com/utmapp/UTM/issues/2688)) <!-- TODO -->
6. Run [the above commands](#usage)

## Acknowledgements

- [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
