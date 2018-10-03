#!/bin/sh

DIR=$(dirname $0)
if [ "$DIR" = "." ]; then
	DIR=$(pwd)
fi

echo "==> Detecting OS"
platform="unknown"
case $(uname) in
	[Dd]arwin*)
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
mkdir $DIR/private
echo "PLATFORM=${platform}" > $DIR/private/platform

echo "==> Linking dotfiles"
cd ~ || exit 1

sh $DIR/setup/links.sh
sh $DIR/setup/${platform}/links.sh

echo "==> Complete!"
