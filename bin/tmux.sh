#! /bin/sh

SESSION=WORK

if ! tmux ls | grep ^$SESSION 
then
    tmux new -s $SESSION -d
    tmux neww -t $SESSION -n cmus -d cmus
    tmux selectw -t cmus
fi

tmux a -t $SESSION
