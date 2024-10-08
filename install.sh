#! /bin/bash

DOTFILES=$HOME/repos/dotfiles

echo "* Link repos from dropbox"
mkdir -p $HOME/repos 
ln -sf $HOME/Dropbox/repos/{blog,dotfiles,password-store,martinuzak.com,pca,spiritualita_po_slovensky} $HOME/repos/


echo "* Remove config files"
rm -f ~/.zshrc
rm -f ~/.zsh-completions
rm -f ~/.vimrc
rm -f ~/.aliases
rm -f ~/.bashrc
rm -f ~/.gitconfig
rm -f ~/.pystartup
rm -f ~/.tmux.conf
rm -f ~/.ackrc
rm -f ~/.ideavimrc
rm -f ~/.newsboat
rm -f ~/.mpdconf
rm -f ~/.vimpcrc
rm -f ~/.psqlrc
rm -rf ~/.config/nvim
rm -f ~/Library/Application\ Support/VSCodium/User/settings.json
rm -f ~/.config/VSCodium/User/settings.json 
rm -rf ~/.ssh 
rm -rf ~/.aws
rm -rf ~/.mpd 
rm -rf ~/.ctags

echo "* Add config symlinks"
ln -s $DOTFILES/zshrc ~/.zshrc
ln -s $DOTFILES/zsh-completions ~/.zsh-completions
ln -s $DOTFILES/vim/vimrc ~/.vimrc
ln -s $DOTFILES/aliases ~/.aliases
ln -s $DOTFILES/bashrc ~/.bashrc
ln -s $DOTFILES/gitconfig ~/.gitconfig
ln -s $DOTFILES/pystartup ~/.pystartup
ln -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -s $DOTFILES/ackrc ~/.ackrc
ln -s $DOTFILES/psqlrc ~/.psqlrc
ln -s $DOTFILES/ideavimrc ~/.ideavimrc
ln -s $DOTFILES/newsboat ~/.newsboat
ln -s $DOTFILES/ctags ~/.ctags
mkdir -p ~/.config/nvim
ln -s $DOTFILES/vim/vimrc ~/.config/nvim/init.vim
if [[ $OSTYPE == 'darwin'* ]]; then
    ln -s $DOTFILES/VSCodium/settings.json ~/Library/Application\ Support/VSCodium/User/settings.json 
    ln -s $DOTFILES/Brewfile ~/.Brewfile
else
    mkdir -p ~/.config/VSCodium/User
    ln -s $DOTFILES/VSCodium/settings.json ~/.config/VSCodium/User/settings.json 
fi

# mpd, vimpc
echo "* mpd, mpc, vimpc"
if [[ $OSTYPE == 'darwin'* ]]; then
    ln -s  $DOTFILES/mpd.conf.osx ~/.mpdconf
else
    ln -s  $DOTFILES/mpd.conf ~/.mpdconf
fi
mkdir ~/.mpd
mkdir -p ~/.mpd/playlists
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
mpc update
ln -s $DOTFILES/vimpcrc ~/.vimpcrc

echo "* SSH and AWS"
ln -s $HOME/Dropbox/.ssh ~
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
ssh-add
ln -s $HOME/Dropbox/.aws ~

# echo "* MPD, vimpc"
# if [[ $OSTYPE == 'darwin'* ]]; then
#     ln -s  $DOTFILES/mpd.conf.osx ~/.mpdconf
# else
#     ln -s  $DOTFILES/mpd.conf ~/.mpdconf
# fi
# mkdir -p ~/.mpd/playlists
# touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
# mpc update
# ln -s $DOTFILES/vimpcrc ~/.vimpcrc
# sudo systemctl restart mpd

if [[ $OSTYPE == 'darwin'* ]]; then
    echo "* Store gpg passphrase in macos keychain"
    mkdir -m 0700 ~/.gnupg
    echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" | tee ~/.gnupg/gpg-agent.conf
    pkill -TERM gpg-agent
    echo test | gpg -e -r martin.uzak@mailbox.org | gpg -d
fi
