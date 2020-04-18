#! /bin/bash

DOTFILES=~/repos/dotfiles

ln -s $DOTFILES/zshrc ~/.zshrc
ln -s $DOTFILES/vim/vimrc ~/.vimrc
ln -s $DOTFILES/aliases ~/.aliases
ln -s $DOTFILES/bashrc ~/.bashrc
ln -s $DOTFILES/pystartup ~/.pystartup

ln -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -s $DOTFILES/ackrc ~/.ackrc
ln -s $DOTFILES/ideavimrc ~/.ideavimrc
ln -s $DOTFILES/emacs.d ~/.emacs.d
ln -s $DOTFILES/newsboat ~/.newsboat

### mail
mkdir -p /martinuzak/.Mail/mailbox
ln $DOTFILES/mail/msmtprc ~/.msmtprc         # symlink doesn't work
ln -s $DOTFILES/mail/mbsyncrc ~/.mbsyncrc
ln -s $DOTFILES/mail/mutt ~/.mutt
ln -s /martinuzak/.mbsync ~/

# mpd, vimpc
ln -s  $DOTFILES/mpd.conf ~/.mpdconf
mkdir ~/.mpd
mkdir -p ~/.mpd/playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
mpc update
ln -s $DOTFILES/vimpcrc ~/.vimpcrc

# git
git config --global core.excludesfile $DOTFILES/gitignore 
git config --global user.email "martin.uzak@gmail.com"
git config --global user.name "Martin Užák"

# ssh
rmdir ~/.ssh
ln -s /martinuzak/.ssh ~/
