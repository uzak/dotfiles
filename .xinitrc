host=$(hostname -s)

if [ -f ~/.Xresources.$host ]
    cat ~/.Xresources ~/.Xresources.$host > ~/.Xresources.generated
    xrdb -merge ~/.Xresources.generated
else
    xrdb -merge ~/.Xresources 
fi
