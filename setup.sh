#!/bin/sh

BASEDIR=$(dirname "$0")

if [ -f "/etc/lsb-release" ]; then
	source /etc/lsb-release
fi

echo "==> Detecting OS"
platform="unknown"
case "$OSTYPE" in
	darwin*)
		platform="mac"
		;;
	FreeBSD)
		platform="freebsd"
		;;
	Linux)
		if [ -f "/etc/lsb-release" ]; then
			platform="debian"
		fi
		if [ -f "/etc/os-release" ]; then
			platform="debian"
		fi
		;;
esac

if [ "unknown" = "${platform}" ]; then
	echo "\tERROR: Unknown platform"
	exit 1
fi
echo "--> ${platform}"

echo "==> Linking dotfiles"
pwd=$(pwd)
cd ~ || exit 1
sh $BASEDIR/setup/links.sh
sh $BASEDIR/setup/${platform}/links.sh

echo "==> Complete!"