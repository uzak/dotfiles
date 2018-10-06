# Ubuntu on T480s

## Install
* normal installation
* use disk encryption

### Basic tools

    sudo apt install git curl htop mc
    sudo apt install geeqie gimp

## Chrome

    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb

## Dropbox

https://unix.stackexchange.com/questions/35624/how-to-run-dropbox-daemon-in-background
https://linoxide.com/linux-how-to/install-dropbox-ubuntu/

    sudo apt install nautilus-dropbox
	sudo -s

	cat << EOF > /etc/systemd/system/dropbox@.service
	[Unit]
	Description=Dropbox as a system service user %i
	
	[Service]
	Type=forking
	ExecStart=/usr/bin/dropbox start
	ExecStop=/usr/bin/dropbox stop
	User=%i
	Group=%i
	# 'LANG' might be unnecessary, since systemd already sets the
	# locale for all services according to "/etc/locale.conf".
	# Run `systemctl show-environment` to make sure.
	Environment=LANG=en_US.utf-8
	
	[Install]
	WantedBy=multi-user.target
	EOF
	
	sudo systemctl enable dropbox@${USER}.service  
	sudo systemctl start dropbox@${USER}.service 
	

## zsh

    sudo apt install zsh fonts-powerline
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cd Dropbox/dotfiles
    ./install.sh
### fonts
    mkdir ~/.local/share/fonts
    ln -s ~/.local/share/fonts ~/.fonts
    cd ~/.fonts
    wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20Bold%20for%20Powerline.ttf
    wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
    
    sudo apt install ttf-dejavu 
    cd ~/repos && git clone https://github.com/supermarin/YosemiteSanFranciscoFont
    cd ~/r/YosemiteSanFranciscoFont
    cp *ttf ~/.fonts
    # replace the default font with "System San Francisco Display 11"
    $EDITOR ~/.gtkrc-2.0
    $EDITOR .config/gtk-3.0/settings.ini


## vim

    sudo apt install vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Now start vim  and run  `VundleUpdate` in the command mode 


## i3wm
https://www.youtube.com/watch?v=j1I63wGcvU4

    sudo apt install i3 i3blocks feh lxappearance arandr 
    sudo apt install xserver-xorg-input-synaptics lm-sensors xbacklight

    mkdir ~/repos
    cd ~/repos && git clone https://github.com/jomiq/i3-wpd

    echo FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 autofitter:warping=1" >> /etc/environment
### Solarized terminal background
https://github.com/Anthony25/gnome-terminal-colors-solarized

    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
    cd gnome-terminal-colors-solarized
    ./install.sh

## skype

    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    sudo dpkg -i skypeforlinux-64.deb
    sudo apt install -f

## java
    sudo apt install default-jre
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt install oracle-java8-installer
    sudo update-alternatives --config java

## docker
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
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

## virtualbox

    sudo apt install virtualbox virtualbox-ext-pack

## pycharm and idea
download, uncompress as root and move to `/opt`, then create symlinks:

    sudo ln -s /opt/**/idea.sh /usr/local/bin/idea
    sudo ln -s /opt/**/pycharm.sh /usr/local/bin/pycharm

## TODO
* virtualbox macosx, win?
* make sure battery stuff always starts
* .gtk config files in .config
