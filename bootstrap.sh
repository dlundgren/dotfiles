#!/bin/sh
#
# This file should only be run on new Macs as it bootstraps the system
#

case "$OSTYPE" in
	darwin*)
		;;
	*)
		echo "Not OS X"
		exit 1
		;;
esac


trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

echo "==> Bootstrapping OS X"

echo "==> Xcode"
if ! command -v cc >/dev/null; then
	echo "--> installing"
	xcode-select --install
fi

echo "==> Homebrew"
if ! command -v brew >/dev/null; then
	echo "--> installing"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
fi

echo "==> Ansible"
if ! command -v ansible >/dev/null; then
	echo "--> installing"
	brew install ansible
fi

echo "==> Running ansible playbook"
ansible-playbook playbook.yml -i localhost, -kK
