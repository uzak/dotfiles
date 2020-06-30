# Ubuntu 20.04 on T480s

## Install

* normal installation
* use disk encryption
* disk layout
    * 1GB /boot
    * 100 MB efi (already created by windows)
    * / encrypted
     
## Environment

    $ cat /etc/environment

    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

    LC_ALL=en_US.UTF-8
    EDITOR=vi

## Basic tools

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install zsh catimg autojump            # zsh + tools for plugins
    sudo apt install vim-gtk3 vim neovim emacs emacs-gtk
    sudo apt install git tig universal-ctags cloc bat ack fzf ripgrep cscope
    sudo apt install tmux mc tree curl net-tools jq fd-find tldr
    sudo apt install iotop iftop htop bmon
    sudo apt install gimp geeqie sixv
    sudo apt install gnome-mpv mpv
    sudo apt install gnome-tweak-tool gnome-shell-extension-suspend-button
    sudo apt install python3 python3-pip pipenv python3-sphinx
    sudo apt install neomutt w3m isync msmtp urlscan ripmime mime-support 
    sudo apt install pass gnupg upass
    sudo apt install ddgr googler translate-shell
    sudo apt install newsboat
    sudo apt install aria2
    sudo apt install neofetch 
    sudo apt install influxdb-client
    sudo apt install nodejs node-typescript
    sudo apt install colordiff
    sudo apt install csvtool

    sudo apt install plantuml drawio
    sudo apt install mythes-sk libreoffice-l10n-sk hyphen-sk
    sudo apt install texlive-fonts-recommended texlive-latex-recommended 
    sudo apt install pandoc texlive-latex-base texlive-xetex
    sudo apt install postix mailutils       # local mail cfg

### Sudo

    sudo -E visudo
    sudo sh -c "echo \"$USER ALL=NOPASSWD: ALL\" >> /etc/sudoers"
    
### zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Snap

    sudo snap install insomnia 
    sudo snap install --classic chromium
    sudo snap install --classic kotlin
    sudo snap install --classic pycharm-community
    sudo snap install --classic intellij-idea-community

### Alternatively remove snapd

	sudo apt autoremove --purge snapd gnome-software-plugin-snap
	sudo rm -rf /var/cache/snapd/


## Skype

    cd ~/Downloads
    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f


## Docker
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo -E add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    sudo apt install docker-ce
    sudo systemctl status docker
    sudo usermod -aG docker ${USER}
    sudo apt install docker-compose

## vimpc

    cd ~/repos
    git clone https://github.com/boysetsfrog/vimpc
    sudo apt install libcurl4-gnutls-dev libpcre++-dev 
    sudo apt-get install build-essential autoconf \
        libmpdclient2 libmpdclient-dev libpcre3 libpcre3-dev \
        libncursesw5 libncursesw5-dev libncurses5-dev \
        libtagc0 libtagc0-dev
    cd vimpc
    ./autogen.sh
    ./configure
    make -j 8
    sudo make install clean
    
    sudo apt install mpd mpc
    sudo service mpd stop
    sudo update-rc.d mpd disable

    
## Slack 

Install manually and not from snap. Snap is slower and has problem opening links in firefox once it is running. [Download](https://slack.com/intl/en-cz/downloads/instructions/ubuntu), install and then run:

    sudo apt --fix-broken install
    
    
## Jekyll/blog

    cd ~/repos/blog
    sudo apt install ruby-bundler
    bundler install
    bundle exec jekyll serve

        
## Firefox

Plugins:
* adblock plus
* facebook container
* google container
* https everywhere
* vue.js devtools
 
Settings:
* ddrg search engine
* 1.1x zoom

    
## Gnome

* super-t - terminal
* 1.25x fonts via tweaks
* slacks and skype in autostart


## Misc

### Mute beeping

    sudo apt install dconf-editor
    dconf-editor
    
Then go to `org/gnome/desktop/sound` and disable `event-sounds`.


### Dispable touchpad
https://askubuntu.com/questions/1085390/how-do-i-disable-the-touchpad-while-typing-ubuntu-18-04

    sudo apt remove xserver-xorg-input-synaptics
    sudo apt install xserver-xorg-input-libinput

### Battery

    sudo apt-get install tlp tlp-rdw acpi-call-dkms tp-smapi-dkms acpi-call-dkms
    sudo tlp start
    tlp-stat -s
    sudo tlp-stat -b
    
    
### Marble mouse

https://unix.stackexchange.com/questions/367106/logitech-marble-mouse-linux-scroll-modifier-setup


### Java

    sudo apt install openjdk-13-jre

or alternatively:

    sudo -E add-apt-repository ppa:linuxuprising/java
    sudo apt-get update
    sudo apt-get install oracle-java13-installer
    sudo update-alternatives --config java
