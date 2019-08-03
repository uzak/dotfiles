if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/uzak/.sdkman"
[[ -s "/home/uzak/.sdkman/bin/sdkman-init.sh" ]] && source "/home/uzak/.sdkman/bin/sdkman-init.sh"
