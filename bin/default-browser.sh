#!/bin/bash
#
# https://askubuntu.com/questions/1000716/default-browser-for-certain-application/1188672#1188672

if [ "$DEFAULT_BROWSER" == "" ]
then
  DEFAULT_BROWSER=google-chrome
fi

$DEFAULT_BROWSER "$@"
