.POSIX:

default: init run

init:
	python3 -m venv .venv
	. .venv/bin/activate
	pip3 install -r requirements.txt
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

run:
	. .venv/bin/activate
	ansible-playbook --ask-become-pass --inventory hosts.ini playbook.yml
