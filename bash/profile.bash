if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

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
