#! /bin/sh

SESSION=WORK

if ! tmux ls | grep ^$SESSION 
then
    tmux new -s $SESSION -d
    tmux neww -t $SESSION -n vimpc -d vimpc.sh
    tmux selectw -t vimpc
fi

tmux a -t $SESSION
