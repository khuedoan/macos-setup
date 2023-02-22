.POSIX:
.PHONY: default build uninstall

default: build

/nix:
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	sh /tmp/nix-install.sh
	@echo "Remove the default Nix configuration file to use the one from nix-darwin"
	cat /etc/nix/nix.conf && sudo rm -i /etc/nix/nix.conf
	/nix/var/nix/profiles/default/bin/nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
	/nix/var/nix/profiles/default/bin/nix-channel --update
	mkdir /tmp/nix-darwin
	cd /tmp/nix-darwin \
		&& . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh \
		&& nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer \
		&& ./result/bin/darwin-installer

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
	/run/current-system/sw/bin/darwin-rebuild switch
