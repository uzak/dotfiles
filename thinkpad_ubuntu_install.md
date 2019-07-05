# Ubuntu on T480s

## Install
* normal installation
* use disk encryption

## Basic tools

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install git curl htop mc net-tools
    sudo apt install vim-gtk3 keepass2 vim zsh
    sudo apt install gimp vlc
    sudo apt install gnome-tweak-tool

### Sudo

    sudo -E visudo

`uzak    ALL=NOPASSWD: ALL`

### Environment

    sudo echo LC_ALL=en_US.UTF-8 >> /etc/environment
    sudo echo EDITOR=vi >> /etc/environment

## Chrome

    sudo apt install chromium-browser


## Skype

    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f

## Java
    sudo apt install openjdk-13-jre

    sudo -E add-apt-repository ppa:linuxuprising/java
    sudo apt-get update
    sudo apt-get install oracle-java11-installer
    sudo update-alternatives --config java

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

## Virtualbox

    sudo apt install virtualbox virtualbox-ext-pack
    sudo apt install rdesktop

## PyCharm and Idea
download, uncompress as root and move to `/opt`, then create symlinks:

    sudo ln -s /opt/**/idea.sh /usr/local/bin/idea
    sudo ln -s /opt/**/pycharm.sh /usr/local/bin/pycharm

## Marble mouse

https://unix.stackexchange.com/questions/367106/logitech-marble-mouse-linux-scroll-modifier-setup

## Remove snapd

	sudo apt autoremove --purge snapd gnome-software-plugin-snap
	sudo rm -rf /var/cache/snapd/

## Git

    git config --global user.email "martin.uzak@gmail.com"
    git config --global user.name "Martin Uzak"
