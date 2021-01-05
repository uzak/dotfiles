#! /bin/sh

# Machine backup script.
# Copyright (C) 2020 Martin Užák <martin.uzak@gmail.com>
#
# Distributed under terms of the MIT license.
#
# install via crontab:
#
## m h  dom mon dow   command
# 30 09 * * * /home/m/repos/scripts/backup.sh

dir=/martinuzak/backup/$(hostname)
mkdir -p $dir
~/repos/dotfiles/bin/backup_music.sh > $dir/music.txt
pip3 freeze > $dir/pip_pkgs.txt
snap list > $dir/snap_pkgs.txt
dpkg -l > $dir/dpkg_list.txt
dpkg --get-selections > $dir/dpkg_selections.txt


# main workstation 
if [ $(hostname) != "t480s" ]; then
    exit 0;
fi

export GNUPGHOME=~/.gnupg
export PASSWORD_STORE_DIR=/home/m/repos/password-store

BACKUP_DIRS=`echo /martinuzak $PASSWORD_STORE_DIR ~/.mozilla/firefox/*/bookmarkbackups`

# TAR to usb stick
if [ -d /media/m/ADATA ] 
then
    mkdir /media/m/ADATA/backup 2>/dev/null
    backup=/tmp/backup_$((`date "+%V"` % 8)).tar    # keep last 8 weeks of backups
    echo "Backup -> $backup"
    tar cf $backup $BACKUP_DIRS 
    xz -v -9 -T 0 $backup
    echo `pass backup_password` | gpg --batch --yes --passphrase-fd 0 -c $backup.xz
    mv -v $backup.xz.gpg /media/m/ADATA/backup
    rm -fv $backup.xz
fi
