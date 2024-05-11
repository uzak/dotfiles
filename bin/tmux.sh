#! /bin/sh

SESSION=WORK

if ! tmux ls | grep ^$SESSION 
then
    tmux new -s $SESSION -d -n htop htop
    tmux neww -t $SESSION -n thor zsh -i -c "thor && make run"
    tmux neww -t $SESSION -n celery_beat zsh -i -c "thor && make celery_beat"
    tmux neww -t $SESSION -n celery_redis zsh -i -c "thor && make celery_worker_redis"
    tmux neww -t $SESSION -n localstack zsh -i -c "thor && make localstack"
    tmux neww -t $SESSION -n loki -c ~/development/pronto-loki make
    tmux selectw -t htop
fi

tmux a -t $SESSION
