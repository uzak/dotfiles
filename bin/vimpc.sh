#! /bin/bash

cleanup() {
    rv=$?
    systemctl --user stop mpd
    exit $rv
}

systemctl --user start mpd
mpc update
vimpc
trap "cleanup" INT TERM EXIT
