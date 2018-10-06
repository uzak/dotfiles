#! /bin/bash

# get rid of existing dotfile and create a symlink to dropbox
function install {
    fn=$1
    dst=${2:-~}
    backup=$(echo $fn.$RANDOM | tr '/' '_')
    [[ -e ~/$fn ]] && mv -v ~/$fn /tmp/$backup
    ln -vs ~/Dropbox/dotfiles/$fn $dst
}

for fn in .xinitrc .Xresources .pystartup .vimrc .zshrc .irbrc .gitconfig; do
    install $fn
done

if [[ $OSTYPE == darwin* ]]; then
    install .hammerspoon
fi

if [[ $OSTYPE == linux-gnu ]]; then
    [[ ! -e ~/.config ]] && mkdir ~/.config
    install .config/i3 ~/.config
fi
