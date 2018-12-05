host=$(hostname -s)

if [ -f ~/.Xresources.$host ]
    xrdb -merge ~/.Xresources ~/.Xresources.$host
else
    xrdb -merge ~/.Xresources 
fi
