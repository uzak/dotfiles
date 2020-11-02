#! /bin/sh

SESSION=WORK

if ! tmux ls | grep ^$SESSION 
then
    tmux new -s $SESSION -d
    tmux neww -t $SESSION -n api-server -d 'cd ~/repos/Prusa-Connect-API'
    tmux neww -t $SESSION -n vimpc -d vimpc.sh
    tmux neww -t $SESSION -n nvim -d 'vi /martinuzak/todo.txt -c "set laststatus=0"'
fi

tmux a -t $SESSION
