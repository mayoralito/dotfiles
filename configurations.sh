#!/bin/bash
set -e

git_config() {
	echo "Configuring git"
	git config --global alias.co "checkout"
	git config --global alias.br "branch"
	git config --global alias.ci "commit"
	git config --global alias.st "status"

	git config --global color.ui true

	git config --global core.editor "/usr/bin/vim"

	echo "Additionally you could use your email and name globally:"
	echo "git config --global user.name \"Adrian Mayoral\""
	echo "git config --global user.email \"mayoralito@gmail.com\""
}

git_config