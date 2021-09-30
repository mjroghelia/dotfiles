source ~/.env
source $ETC_DIR/bash/project.bash

#alias ss='svn stat'
alias ss='git status -s'
alias be='bundle exec'
alias ls='ls -G'

# Don't overwrite the bash history when I leave a session.  This plays better with multiple concurrent sessions
shopt -s histappend

export TERM=xterm-256color
export EDITOR='vim --nofork'
export GIT_EDITOR="$EDITOR -c start"
export VIM_GUI=false
export PS1="\[\e[0;34m\]\w \[\e[1;37m\]\$\[\e[0m\] "

export PYTHONPATH=~/src/etc/python:$PYTHONPATH

PATH=~/bin:~/src/etc/bin:$PATH

if [ "$ETC_PLATFORM" == "mac" ]; then

  # Homebrew and personal scripts
  PATH=/usr/local/bin:$PATH

  # Unbind C-s so vim can use it
  bind -r '\C-s'
  stty -ixon

  # Git command completion - brew install bash-completion
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

if which rbenv > /dev/null; then
  PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)";
fi

export PATH
