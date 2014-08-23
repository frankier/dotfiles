[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="agnoster"
#ZSH_THEME="mortalscumbag"
ZSH_THEME="frankie"
#ZSH_THEME="kardan"
#ZSH_THEME="ys"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(archlinux git git-flow github history-substring-search pip python sbt scala systemd vi-mode virtualenv virtualenvwrapper vundle) # autoenv 

source $ZSH/oh-my-zsh.sh

# --- ^ oh-my-zsh stuff ^ -- v normal zsh stuff v --- #

setopt extendedglob

# --- ^ normal zsh stuff ^ -- v environment stuff v --- #

export GOPATH=$HOME/code/go/

path+=$HOME/bin
path+=$HOME/.local/bin
#/sbin
#/usr/local/bin
path+=$HOME/.gem/ruby/1.9.1/bin
path+=$GOPATH/bin
#path+=$HOME/yasrc/llvm32build/bin
#path+=/home/frankier/yasrc/build/Release+Asserts/bin
#path+=/home/frankier/yasrc/emscripten

path=($^path(N)) # Strip out $PATH dirs that don't exist

export EDITOR=vim

#export WORKON_HOME=~/programming/python/envs/
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2

#source /usr/bin/virtualenvwrapper.sh
#source /usr/bin/activate.sh # autoenv

alias showdot='dot -Tpdf \!:1 > /tmp/\!:1.pdf && xpdf /tmp/\!:1.pdf && rm -f /tmp/\!:1.pdf'
alias quickweb='python -m SimpleHTTPServer 9001'
alias gogo='cd ~/code/go/src/frankie.robertson.name/'
