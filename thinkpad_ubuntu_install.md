# Ubuntu on T480s

## Install
* normal installation
* use disk encryption

## Basic tools

    sudo apt update
    sudo apt dist-upgrade
    sudo apt install git curl htop mc net-tools
    sudo apt install vim-gtk3 keepass2 vim zsh xdotool
    sudo apt install gimp vlc mpv
    sudo apt install gnome-tweak-tool
    sudo apt install aria2
    sudo apt install mythes-sk libreoffice-l10n-sk hyphen-sk
    sudo apt install cloc


### Sudo

    sudo -E visudo

`uzak    ALL=NOPASSWD: ALL`

### Environment

    cat /etc/environment


    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

    LC_ALL=en_US.UTF-8
    MOZ_ENABLE_WAYLAND=1 thunderbird
    EDITOR=vi

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

http://octavifs.me/post/hidpi-support-on-ubuntu-19-04/

    xrandr --output eDP-1 --scale 1.5x1.5
