# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/Cellar/python3/3.7.0/bin/:/usr/local/bin:/Library/PostgreSQL/9.6/bin:~/.cabal/bin:$PATH:/Users/uzak/tools:/usr/local/texlive/2016/bin/x86_64-darwin:/usr/local/Cellar/rabbitmq/3.6.9_1/sbin/

export ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
plugins=(shrink-path git pip brew common-aliases jsontools osx web-search rand-quote)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.utf8
export LC_CTYPE=en_US.utf8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias s="cd .."
alias rm="rm -f"
alias vi=vim

if [[ $OSTYPE == linux-gnu ]]; then
    alias ls="ls --color -N"
fi

export PYTHONSTARTUP=~/.pystartup

#export PYSPARK_DRIVER_PYTHON=ipython
#export PYSPARK_PYTHON=/anaconda/bin/python
#export PYSPARK_DRIVER_PYTHON_OPTS="notebook --NotebookApp.open_browser=False --NotebookApp.ip='*' --NotebookApp.port=8880"
alias pysparkcli="(PYSPARK_DRIVER_PYTHON="" PYSPARK_DRIVER_PYTHON_OPTS="" && pyspark)"

export PYTHONPATH=$PYTHONPATH:~/work/tapyr

if [[ -e $HOME/.motd ]]; then
    cat $HOME/.motd
fi

#pushd ~/work/sandbox/python
#pushd ~/work/AptoideBigData/Social/src

alias rf="python ~/work/sandbox/python/reformat.py"

setopt auto_cd
cdpath=($HOME/work $HOME $HOME/work/sandbox $HOME/Desktop $HOME/Dropbox)
alias python=python3

export LC_ALL="en_US.UTF-8"

#https://stackoverflow.com/questions/33817282/auto-completion-not-work-for-command-du
#alias du=gdu

# golang
export GOPATH=~/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# for gnu sed
#   PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

export PATH=$PATH:/usr/local/Cellar/sphinx/2.2.11/bin/
export GOROOT=/usr/local/opt/go/libexec

#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ANDROID_HOME=~/Library/Android/sdk/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export SECRET_KEY="zsDfcbldmfjsklmowMNTJT/bQR7QQWw4ersVBHr6dsg-457f(fNJKEYfr"

export PATH=$ANDROID_HOME/platform-tools:$PATH
#alias pip=pip3
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass

setopt prompt_subst

# https://github.com/wesbos/Cobalt2-iterm/issues/15
prompt_dir() {
    prompt_segment blue black $(shrink_path -f)
}
export HELM_HOME=~/.helm
export PATH=$PATH:~/go/bin:~/kops/bin

export PATH=~/bin:$PATH
alias glances="glances --theme-white"

function td_docker_shell() {
    docker exec -ti $(docker ps | grep elsacorp/teacher-api/api | awk '{ print $1 }') /bin/bash
}

#alias java=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home/bin/java

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line
