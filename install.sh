#! /bin/bash

if [[ "DELETE" == "DELETE" ]]; then
    rm -f ~/.zshrc
    rm -f ~/.vimrc
    rm -f ~/.aliases
    rm -f ~/.bashrc
    rm -f ~/.gitconfig
    rm -f ~/.pystartup
    rm -f ~/.tmux.conf
    rm -f ~/.ackrc
    rm -f ~/.ideavimrc
    rm -f ~/.newsboat
    rm -f ~/.ssh
fi

DOTFILES=$HOME/repos/dotfiles

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s $DOTFILES/zshrc ~/.zshrc
ln -s $DOTFILES/vim/vimrc ~/.vimrc
ln -s $DOTFILES/aliases ~/.aliases
ln -s $DOTFILES/bashrc ~/.bashrc
ln -s $DOTFILES/gitconfig ~/.gitconfig
ln -s $DOTFILES/pystartup ~/.pystartup

ln -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -s $DOTFILES/ackrc ~/.ackrc
ln -s $DOTFILES/ideavimrc ~/.ideavimrc
ln -s $DOTFILES/newsboat ~/.newsboat
mkdir -p ~/.config/nvim
ln -s $DOTFILES/vim/vimrc ~/.config/nvim/init.vim
mkdir -p ~/.config/kitty
ln -s $DOTFILES/kitty.conf ~/.config/kitty/kitty.conf

if [[ $HOST == 't480s' || $HOST == 'air' ]]; then
    ln -s $HOME/Dropbox/{blog,dotfiles,password-store} $HOME/repos/
fi

# mpd, vimpc
ln -s  $DOTFILES/mpd.conf ~/.mpdconf
mkdir ~/.mpd
mkdir -p ~/.mpd/playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
mpc update
ln -s $DOTFILES/vimpcrc ~/.vimpcrc

# ssh
rmdir ~/.ssh 2>/dev/null || true
ln -s $HOME/Dropbox/.ssh ~

