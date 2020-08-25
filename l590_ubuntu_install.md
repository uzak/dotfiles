# Ubuntu 20.04 on L590

## Install

* normal installation
* use disk encryption, full disk
  
### Sudo

    sudo -E visudo
    sudo sh -c "echo \"$USER ALL=NOPASSWD: ALL\" >> /etc/sudoers"
     
## Environment

    $ cat /etc/environment

    LC_ALL=en_US.UTF-8
    EDITOR=vi

## Basic tools

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install zsh autojump            # zsh + tools for plugins
    sudo apt install vim neovim emacs emacs-gtk
    sudo apt install git tig cloc bat ack fzf ripgrep 
    sudo apt install tmux mc tree curl net-tools jq fd-find tldr
    sudo apt install iotop iftop htop bmon
    sudo apt install gimp 
    sudo apt install gnome-tweak-tool gnome-shell-extension-suspend-button
    sudo apt install python3 python3-pip pipenv python3-sphinx
    sudo apt install pass gnupg upass
    sudo apt install ddgr googler translate-shell
    sudo apt install newsboat
    sudo apt install neofetch 
    sudo apt install influxdb-client
    sudo apt install nodejs node-typescript
    sudo apt install colordiff
    sudo apt install csvtool
    sudo apt install lm-sensors
    sudo apt install plantuml 
    sudo apt install fonts-firacode
    
    sudo apt autoremove


## Snap

    sudo snap install insomnia 
    sudo snap install --classic chromium
    sudo snap install --classic pycharm-community
    
### zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


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

    
## Slack 

Install manually and not from snap. Snap is slower and has problem opening links in firefox once it is running. [Download](https://slack.com/intl/en-cz/downloads/instructions/ubuntu), install and then run:

    sudo apt --fix-broken install
    
    
## Gnome

* 1.25x fonts via tweaks
* slacks and skype in autostart


## Misc

### Mute beeping

    sudo apt install dconf-editor
    dconf-editor
    
Then go to `org/gnome/desktop/sound` and disable `event-sounds`.


### Marble mouse

https://unix.stackexchange.com/questions/367106/logitech-marble-mouse-linux-scroll-modifier-setup
