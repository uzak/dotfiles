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
cdpath=($HOME $HOME/repos $HOME/Desktop $HOME/Dropbox)

#export LC_ALL="fr_FR.UTF-8"

# for gnu sed
#   PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

setopt prompt_subst

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH:$HOME/repos/dotfiles/bin"
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
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || rg --files --no-ignore-vcs --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export BAT_PAGER="less -R"
export BAT_THEME="Monokai Extended"

unset MOZ_NO_REMOTE

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>\/:\"'\'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>:\"'\'

# https://www.thregr.org/~wavexx/rnd/20141010-zsh_show_ambiguity/index.html
zstyle ':completion:*' show-ambiguity true
zstyle ':completion:*' show-ambiguity "$color[bg-white]"

# open
function o {
    dir=${1:-.}
    (cd $dir && open `fzf`)
}


export PATH="/usr/lib/cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH" # pip installs
export EDITOR=nvim

function upgrade () {
    sudo apt update
    sudo apt -y dist-upgrade 
    sudo apt -y autoremove
    sudo apt-get clean
    pip install -U youtube-dl
}

export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

fpath=(~/.zsh-completions $fpath)
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2

export PATH=$PATH:~/.cargo/bin


