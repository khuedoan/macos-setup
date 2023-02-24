.POSIX:
.PHONY: default build uninstall

default: build

/nix:
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	sh /tmp/nix-install.sh
	# TODO https://github.com/LnL7/nix-darwin/issues/149
	cat /etc/nix/nix.conf && sudo rm -i /etc/nix/nix.conf

/opt/homebrew/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
	bash /tmp/brew-install.sh

~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -f "$@"

~/.git: ~/.ssh/id_ed25519
	cd ~ \
		&& git init \
		&& git config status.showUntrackedFiles no \
		&& git remote add origin https://github.com/khuedoan/dotfiles \
		&& git pull origin master \
		&& git remote set-url origin git@github.com:khuedoan/dotfiles

build: /nix /opt/homebrew/bin/brew ~/.git
	nix --experimental-features 'nix-command flakes' build ./\#darwinConfigurations.MacBookAir.system
	./result/sw/bin/darwin-rebuild switch --flake .
