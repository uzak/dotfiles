#! /bin/bash

cleanup() {
    rv=$?
    systemctl --user stop mpd
    exit $rv
}

[[ "$OSTYPE" == "linux-gnu"* ]] && systemctl --user start mpd
mpc update
vimpc
[[ "$OSTYPE" == "linux-gnu"* ]] && trap "cleanup" INT TERM EXIT
