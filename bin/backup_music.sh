#!/bin/bash
#
# Usage: MUSIC_DIR=~/m backup_music.sh > ~/Dropbox/music.txt

MUSIC_DIR=${MUSIC_DIR:-~/Music}

strip_n=$(echo $MUSIC_DIR | wc -c)
strip_n=$(($strip_n + 1))  # add trailing `/`

find $MUSIC_DIR -type f | grep -E  '(\-\S{11}|\[\S{11}\])\.mp3' | cut -b$strip_n-
