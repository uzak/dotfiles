#! /bin/bash

# get rid of existing dotfile and create a symlink to dotfiles
function install {
    src=$1
    dst="${2:-`dirname ~/$src`}"
    backup=$(echo "$src.$RANDOM" | tr '/' '_')
    dotfiles_dir="$(pwd)"
    if [[ -h "~/$src" ]]; then
        mv -v "~/$src" /tmp/$backup 
    fi 
    ln -fvs "$dotfiles_dir/$src" "$dst"
}

for fn in .vimrc .aliases .bashrc .zshrc .pystartup; do
    install $fn 
done
