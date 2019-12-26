# Ubuntu on T480s

## Install
* normal installation
* use disk encryption

## Basic tools

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install git curl htop mc bmon net-tools
    sudo apt install vim-gtk3 keepass2 vim zsh 
    sudo apt install gimp mpv moc
    sudo apt install gnome-tweak-tool
    sudo apt install aria2
    sudo apt install mythes-sk libreoffice-l10n-sk hyphen-sk
    sudo apt install cloc tree
    sudo apt install python3 python3-pip pipenv

### Sudo

    sudo -E visudo
    sudo sh -c "echo \"$USER ALL=NOPASSWD: ALL\" >> /etc/sudoers"

### Environment

    $ cat /etc/environment

    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

    LC_ALL=en_US.UTF-8
    EDITOR=vi

## Snap

    sudo snap install chromium insomnia intellij-idea-community kotlin pycharm-community

### Alternatively remove snapd

	sudo apt autoremove --purge snapd gnome-software-plugin-snap
	sudo rm -rf /var/cache/snapd/

## Vim

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Now start vim  and run  `VundleUpdate` in the command mode 


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

## Marble mouse

https://unix.stackexchange.com/questions/367106/logitech-marble-mouse-linux-scroll-modifier-setup

## Git

    git config --global user.email "martin.uzak@gmail.com"
    git config --global user.name "Martin Užák"

## Mute beeping

http://ubuntuhandbook.org/index.php/2019/03/disable-mute-alert-sound-ubuntu-19-04/

## Apple keyboard
Use keyboard layout _English (Macintosh)_

Create an autostart script for Xmodmap and chmod a+x it

    cat ~/.config/autostart/keyboard.sh
    #!/bin/bash
    xmodmap ~/.Xmodmap

hid\_apple module settings

    cat /etc/modprobe.d/hid_apple.conf    
    options hid_apple fnmode=2
    options hid_apple swap_opt_cmd=0

Disable wakup from USB (bluetooth keyboard). Press and hold ``fn`` to wakeup or
use poweron button or open the lid.

    echo XHC > /proc/acpi/wakeup

## Misc

https://askubuntu.com/questions/1085390/how-do-i-disable-the-touchpad-while-typing-ubuntu-18-04

    sudo apt remove xserver-xorg-input-synaptics
    sudo apt install xserver-xorg-input-libinput

battery:

    sudo apt-get install tlp tlp-rdw acpi-call-dkms tp-smapi-dkms acpi-call-dkms
    sudo tlp start
    tlp-stat -s
    sudo tlp-stat -b
