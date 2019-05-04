#! /bin/bash

# set hostname
if [[ $OSTYPE == msys ]]; then
    HOST=$(hostname)
else
    HOST=$(hostname -s)
fi

# get rid of existing dotfile and create a symlink to dotfiles
function install {
    src=$1
    dst="${2:-`dirname ~/$src`}"
    backup=$(echo "$src.$RANDOM" | tr '/' '_')
    dotfiles_dir="`pwd`"
    if [[ -h "~/$src" ]]; then
        mv -v "~/$src" /tmp/$backup 
    fi 
    ln -fvs "$dotfiles_dir/$src" "$dst"
}

for fn in .pystartup .vimrc .zshrc .irbrc .aliases .bashrc; do
    install $fn 
done


if [[ $OSTYPE == darwin* ]]; then
    install .hammerspoon
fi

if [[ $OSTYPE == linux-gnu ]]; then
    mv ~/.Xresources /tmp
    if [ -f .Xresources.$HOST ]; then
        install .Xresources.$HOST ~/.Xresources
    else 
        install .Xresources
    fi
    install .xinitrc

    [[ ! -e ~/.config ]] && mkdir ~/.config
    install .gtkrc-2.0
    rm -f ~/.config/i3
    install .config/i3.$HOST ~/.config/i3
    install .config/gtk-3.0/settings.ini # ~/.config/gtk-3.0
fi
