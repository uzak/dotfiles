#!/usr/bin/env bash

INPUT_FILE=$1
WORK_DIR=${2:-.}
OLD_WD=`pwd`

mkdir -p $WORK_DIR
cd $WORK_DIR

cat $INPUT_FILE | while read line; do
    echo Processing: $line

    id=`echo $line | grep -oP '\-\K\S{11}\.mp3$' | cut -b-11`
    dir=`dirname "$line"`

    # create the dir download the song
    (
        mkdir -p $dir
        cd $dir
        youtube-dl -i -x --audio-format mp3 https://www.youtube.com/watch\?v\=$id
    )
done

cd $OLD_WD
