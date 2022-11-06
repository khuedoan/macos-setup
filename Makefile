.POSIX:
.PHONY: default build uninstall

default: build

/nix:
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	less /tmp/nix-install.sh
	sh /tmp/nix-install.sh
	@echo "Remove the default Nix configuration file to use the one from nix-darwin"
	sudo rm -i /etc/nix/nix.conf
	mkdir /tmp/nix-darwin
	cd /tmp/nix-darwin \
		&& nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
		&& ./result/bin/darwin-installer

~/.git:
	cd ~ \
		&& git init \
		&& git config status.showUntrackedFiles no \
		&& git remote add origin https://github.com/khuedoan/dotfiles \
		&& git pull origin master

build: /nix ~/.git
	darwin-rebuild switch

uninstall:
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A uninstaller
	./result/bin/darwin-uninstaller
