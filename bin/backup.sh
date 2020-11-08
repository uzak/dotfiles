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

dir=/martinuzak/config/$(hostname)
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

export GNUPGHOME=/martinuzak/.gnupg
export PASSWORD_STORE_DIR=/home/m/repos/password-store

BACKUP_DIRS=`echo /martinuzak ~/.mozilla/firefox/*/bookmarkbackups ~/.config/rclone ~/repos/blog`

# TAR to usb stick
if [ -d /media/m/ADATA ] 
then
    mkdir /media/m/ADATA/backup 2>/dev/null
    backup=/media/m/ADATA/backup/backup_$((`date "+%V"` % 8)).tar    # keep last 8 weeks of backups
    echo "Backup -> $backup"
    tar cf $backup $BACKUP_DIRS ~/repos
    echo `pass backup_password` | gpg --batch --yes --passphrase-fd 0 -c $backup
    rm -fv $backup
fi

# Google Cloud
grep google-drive ~/.config/rclone/rclone.conf > /dev/null 
if [ $? = 0 ]
then
    echo "Backup -> google-drive"
    backup=/tmp/martinuzak_$((`date "+%d"` % 7)).tar
    tar cf $backup $BACKUP_DIRS
    xz -T8 -9 -v $backup
    echo `pass backup_password` | gpg --batch --yes --passphrase-fd 0 -c $backup.xz
    rm -fv $backup $backup.xz
    rclone copy --retries 3 $backup.xz.gpg google-drive:/backup
fi
