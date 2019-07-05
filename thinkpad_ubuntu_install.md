# Ubuntu on T480s

## Install
* normal installation
* use disk encryption

## Basic tools

    sudo apt install git curl htop mc net-tools
    sudo apt install vim-gtk3 keepass2
    sudo apt install geeqie gimp
    sudo apt install vlc
    sudo apt install gnome-tweak-tool

### Sudo

    sudo -E visudo

`uzak    ALL=NOPASSWD: ALL`

### Environment

    sudo echo LC_ALL=en_US.UTF-8 >> /etc/environment
    sudo echo EDITOR=vi >> /etc/environment

## Chrome

    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb

## zsh

    sudo apt install zsh fonts-powerline
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cd ~/repos/dotfiles
    ./install.sh
### fonts
    mkdir ~/.local/share/fonts
    ln -s ~/.local/share/fonts ~/.fonts
    cd ~/.fonts
    wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20Bold%20for%20Powerline.ttf
    wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
    
    sudo apt install ttf-dejavu 
    cd ~/repos && git clone https://github.com/supermarin/YosemiteSanFranciscoFont
    cd YosemiteSanFranciscoFont
    cp *ttf ~/.fonts

## vim

    sudo apt install vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Now start vim  and run  `VundleUpdate` in the command mode 


## i3wm
https://www.youtube.com/watch?v=j1I63wGcvU4

    sudo apt install i3 i3blocks feh lxappearance arandr xautolock
    sudo apt install xserver-xorg-input-synaptics lm-sensors xbacklight

    mkdir ~/repos
    cd ~/repos && git clone https://github.com/jomiq/i3-wpd

fix the backlight:

    sudo cat >> /etc/X11/xorg.conf << EOF
    Section "Device"
        Identifier  "Intel Graphics" 
        Driver      "intel"
        Option      "Backlight"  "intel_backlight"
    EndSection
    EOF

## Skype

    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f

## Java
    sudo apt install default-jre
    sudo -E add-apt-repository ppa:webupd8team/java
    sudo apt install oracle-java8-installer
    sudo update-alternatives --config java

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

## battery
https://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html

    sudo add-apt-repository ppa:linrunner/tlp
    sudo apt-get update
    sudo apt-get install tlp tlp-rdw 
    sudo systemctl status tlp
    sudo tlp start 
    sudo tlp-stat -s 

## Virtualbox

    sudo apt install virtualbox virtualbox-ext-pack
    sudo apt install rdesktop

## PyCharm and Idea
download, uncompress as root and move to `/opt`, then create symlinks:

    sudo ln -s /opt/**/idea.sh /usr/local/bin/idea
    sudo ln -s /opt/**/pycharm.sh /usr/local/bin/pycharm

## Keyboard layouts
    
    sudo apt install x11-xkb-utils
    setxkbmap us
    setxkbmap sk

## Marble mouse

https://unix.stackexchange.com/questions/367106/logitech-marble-mouse-linux-scroll-modifier-setup

## Lock screen on lid close

https://www.reddit.com/r/i3wm/comments/9ebemt/locking_i3_when_lid_of_laptop_is_closed/

    apt-get install xss-lock

## Remove snapd

	sudo apt autoremove --purge snapd gnome-software-plugin-snap
	sudo rm -rf /var/cache/snapd/

## Git

    git config --global user.email "martin.uzak@gmail.com"
    git config --global user.name "Martin Uzak"

