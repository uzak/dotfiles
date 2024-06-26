# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
HIST_STAMPS="yyyy-mm-dd"

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
plugins=(aws autojump command-not-found common-aliases compleat copyfile docker docker-compose git jsontools kubectl npm pip python terraform yarn web-search pass fzf rsync urltools encode64)

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
#   export EDITOR='gvim'
# fi

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
#
source $HOME/.aliases

setopt auto_cd
cdpath=($HOME $HOME/development $HOME/repos $HOME/Desktop $HOME/Dropbox)

# for gnu sed
#   PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

setopt prompt_subst

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export GEM_HOME="$HOME/gems"
export PATH="$PATH:$HOME/gems/bin"
export PATH="$PATH:$HOME/repos/dotfiles/bin"
export PATH="$PATH:$HOME/repos/blog/bin"
export PATH="$PATH:/snap/bin/"

export PYTHONPATH=$PYTHONPATH:~/repos/
export PYTHONSTARTUP=~/.pystartup
export MYVIMRC=~/.vimrc

export GNUPGHOME="~/.gnupg"
export PASSWORD_STORE_DIR="$HOME/repos/password-store"
export PASSWORD_STORE_GIT=$PASSWORD_STORE_DIR

# Configure fzf, command line fuzzyf finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='ctrl-f:execute(bat --style=numbers {} || less -f {}),ctrl-p:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xsel -b),ctrl-x:execute(rm -i {+})+abort'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || rg --files --no-ignore-vcs --hidden || fd ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export BAT_PAGER="less -R"
export BAT_THEME="Monokai Extended"

unset MOZ_NO_REMOTE

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>\/:\"'\'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>:\"'\'

# https://www.thregr.org/~wavexx/rnd/20141010-zsh_show_ambiguity/index.html
zstyle ':completion:*' show-ambiguity true
zstyle ':completion:*' show-ambiguity "$color[bg-white]"

export EDITOR=nvim

# open
function o {
    dir=${1:-.}
    (cd $dir && open `fzf`)
}

function upgrade () {
    if [[ $OSTYPE == linux-gnu* ]]; then
        sudo apt update
        sudo apt -y dist-upgrade 
        sudo apt -y autoremove
        sudo apt-get clean
        sudo snap refresh
    else
        brew update
        brew upgrade
        brew cleanup
        brew doctor
    fi
    omz update
    cleanup
}

function cleanup () {
    rm -v ~/Dropbox/**/*conflicted* 2>/dev/null
}

function dl_mp3 () {
    if [[ $OSTYPE == 'darwin'* ]]; then
        yt-dlp --extract-audio --audio-format mp3 $1
    else
        ~/venv/bin/yt-dlp --extract-audio --audio-format mp3 $1
    fi
}

# unalias egrep
# function egrep () {
#     ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -E "$@"
# }

export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

fpath=(~/.zsh-completions $fpath)
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2

export PATH="/usr/lib/cargo/bin:$PATH"
export PATH=$PATH:~/.cargo/bin
export PATH="$HOME/.local/bin:$PATH" # pip installs
#export PATH=/opt/homebrew/Cellar/python@3.10/3.10.2/bin/:$PATH
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"   # for gnu-grep

export LC_ALL=en_US.UTF-8

function vo() {
    vi `fzf`
}
#export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

#
# current work setup
# 
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/development
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
source /opt/homebrew/bin/virtualenvwrapper.sh 2>/dev/null
export VIRTUALENVWRAPPER_VIRTUALENV=/opt/homebrew/bin/virtualenv
export NVM_DIR="$HOME/.nvm"
export NODE_OPTIONS=--openssl-legacy-provider
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

function thor () {
    cd ~/development/pronto-thor
    source project_env.sh
    source ~/.virtualenvs/thor/bin/activate
    # workon thor
}

function sam_forms () {
    cd ~/development/sam_forms
    source project_env.sh
    source ~/.virtualenvs/sam_forms/bin/activate
    # workon sam_forms
}

export SOPS_KMS_ARN="arn:aws:kms:us-east-1:091647877719:key/11da7ed8-01c7-4443-91f5-081d73c12913"
