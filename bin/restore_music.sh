#!/usr/bin/env bash

if [ ! "$#" -eq 2 ]; then
    # restore_music.sh ~/Dropbox/music.txt ~/Music
    echo "Usage: $0 backup.txt output_dir"
    exit 1
fi

INPUT_FILE=`realpath $1`
WORK_DIR=${2:-.}
OLD_WD=`pwd`

mkdir -p $WORK_DIR
cd $WORK_DIR

youtube-dl --rm-cache-dir

dl_mp3 () {
	if [[ $OSTYPE == 'darwin'* ]]
	then
		yt-dlp --extract-audio --audio-format mp3 $1
	else
		~/venv/bin/yt-dlp --extract-audio --audio-format mp3 $1
	fi
}


cat $INPUT_FILE | while read line; do
    echo Processing: $line

    id=`echo $line | grep -oP '\-\K\S{11}\.mp3$' | cut -b-11`
    # there are two formats
    if [ -z $id ]; then
        id=`echo $line | grep -oP '\[\K\S{11}\]\.mp3$' | cut -b-11`
    fi
    dir=`dirname "$line"`

    # create the dir, download the song
    (
        mkdir -p "$dir"
        cd "$dir"
        # download if not yet present 
        ls *$id*.mp3 2>/dev/null || dl_mp3 https://www.youtube.com/watch\?v\=$id
    )
done

cd $OLD_WD
