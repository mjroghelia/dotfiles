source ~/.env

if [ -n "$ETC_DIR" ]
then
  source $ETC_DIR/bash/project.bash
fi

alias ss='git status -s'
alias be='bundle exec'

# Don't overwrite the bash history when I leave a session.  This plays better with multiple concurrent sessions
shopt -s histappend

export TERM=xterm-256color
export EDITOR='vim --nofork'
export GIT_EDITOR="$EDITOR -c start"
export VIM_GUI=false
export PS1="\[\e[0;34m\]\w \[\e[1;37m\]\$\[\e[0m\] "

export PYTHONPATH=~/src/etc/python:$PYTHONPATH

PATH=~/bin:~/src/etc/bin:~/.local/bin:$PATH

if [ "$ETC_PLATFORM" == "mac" ]; then

  # Homebrew and personal scripts
  PATH=/usr/local/bin:$PATH

  # Unbind C-s so vim can use it
  bind -r '\C-s'
  stty -ixon

  # Git command completion - brew install bash-completion
  if type brew &>/dev/null
  then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
    then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi
  fi

fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

if which rbenv > /dev/null; then
  PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)";
fi

export PATH
