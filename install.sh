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

for fn in .vimrc .aliases .bashrc .zshrc .pystartup .Xmodmap; do
    install $fn 
done

# (optional) lightline colorcli scheme
# do this only after vim and its modules have been installed
curl -fLo ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/colorcli.vim https://raw.githubusercontent.com/jonasjacek/colorcli/master/colorcli.vim

ln -s ~/repos/dotfiles/tmux.conf ~/.tmux.conf

ln -s ~/repos/dotfiles/cmus  ~/.config




### mail
mkdir -p /martinuzak/.Mail/{mailbox,prusa,gmail}

ln ~/repos/dotfiles/mail/msmtprc ~/.msmtprc         # symlink doesn't work
ln -s ~/repos/dotfiles/mail/mbsyncrc ~/.mbsyncrc
ln -s ~/repos/dotfiles/mail/mutt ~/.mutt

vdirsyncer discover
vdirsyncer sync
mbsync -a
mu -m /martinuzak/.Mail index rebuild


# contacts
mkdir -p /martinuzak/.Contacts

mkdir ~/.vdirsyncer
ln -s ~/repos/dotfiles/contacts/vdirsyncer/config ~/.vdirsyncer

mkdir -p ~/.config/khard
ln -s ~/repos/dotfiles/contacts/khard/khard.conf ~/.config/khard

