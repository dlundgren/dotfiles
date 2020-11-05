#!/usr/bin/env bash
[ ! -d ~/.ssh ] && ln -s ~/Dropbox/configs/ssh .ssh
[ ! -e ~/.gitconfig ] && ln -s ~/dotfiles/utils/gitconfig .gitconfig
[ ! -d ~/.lein ] && mkdir .lein
[ ! -e ~/.lein/profiles.clj ] && ln -s ~/dotfiles/utils/lein_profiles.clj .lein/profiles.clj

# PHP development
[ ! -e ~/bin/box ] && ln -s ~/bin/box.phar ~/bin/box
[ ! -e ~/bin/composer ] && ln -s ~/bin/composer.phar ~/bin/composer
[ ! -e ~/bin/deployer ] && ln -s ~/bin/deployer.phar ~/bin/deployer

# link our bins
find ~/dotfiles/bin/ -maxdepth 1 -print "%P\n" | while read file; do ln -s ~/bin/$file $file; done