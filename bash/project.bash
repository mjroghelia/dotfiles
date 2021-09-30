if [ -z "$PROJECTS_DIR" ]
then
  PROJECTS_DIR=~/src
fi

function set_project {

  if [ -n "$1" ]
  then
    export PROJECT_NAME=$1
    export PROJECT_PATH=$PROJECTS_DIR/$1
    export VIM_PROJECT=$1
  fi
}

function project_prompt {

  local pathpart

  if [[ $PWD == ${PROJECT_PATH}* ]] # are we currently somewhere inside the project directory?
  then
    # display working directory relative to the project directory
    local escaped_home=$(echo $HOME | sed -e "s/\//\\\\\//g")
    pathpart=$(pwd | sed -e "s/^$escaped_home\/src\/$PROJECT_NAME//" -e "s/^\// /")
  else
    # display working directory as absolute path
    pathpart=" $PWD"
  fi

  local branch_color

  if [[ $(git status 2> /dev/null) =~ "working tree clean" ]]; then
    branch_color="\e[0;32m"
  else
    branch_color="\e[1;31m"
  fi

  # 0 33 - orange
  # 0;37 bright white
  export PS1="\[\e[0;33m\]$PROJECT_NAME\[$branch_color\]$(__git_ps1)\[\e[0;34m\]$pathpart \[\e[1;37m\]$\[\e[0m\] "
}

function set_iterm_title {
  echo -ne "\033]0;$1\007"
}

# Go to a project by changing directories and setting up Vim
function pd {

  set_project $1

  if [ -n "$PROJECT_NAME" ]
  then

    # create a project specific prompt
    export PROMPT_COMMAND=project_prompt

    set_iterm_title $PROJECT_NAME

    alias gvim='pvim'

    if [ -d $PROJECT_PATH/.git ]
    then
       alias ss='git status -s'
    else
       alias ss='svn stat'
    fi

    cd $PROJECT_PATH

    if [ -e $PROJECT_PATH/venv/bin/activate ]
    then
      . $PROJECT_PATH/venv/bin/activate
    fi

  else
    echo "No project set." 1>&2
    return 1
  fi

}

# Completion function for project names in ~/src
function complete_project_names {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  # Do a directory completion, then trim off the $PROJECTS_DIR part of the path
  local len
  len=$((${#PROJECTS_DIR} + 2))
  COMPREPLY=( $( compgen -d "$PROJECTS_DIR/$cur" | cut -c $len- ) )
}

complete -F complete_project_names pd
