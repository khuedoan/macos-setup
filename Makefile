.POSIX:

default: init run

init:
	python3 -m venv .venv
	. .venv/bin/activate
	pip install -r requirements.txt

run:
	. .venv/bin/activate
	ansible-playbook --ask-become-pass playbook.yml
