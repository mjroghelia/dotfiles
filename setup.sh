#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)

echo "Setting up environment..."

if [[ "$CODESPACES" == "true" ]] && [[ "$GITHUB_REPOSITORY" == "github/"* ]]; then
  export ETC_WORK=true
fi

if [[ "$OSTYPE" == "linux-gnu" ]] && [[ $(lsb_release -si) == "Ubuntu" ]]; then
  echo "Installing Python 3..."
  sudo apt update
  sudo apt install -y python3 python3-pip
fi

export PYTHONPATH=$DIR/python:$PYTHONPATH

echo "Installing Python dependencies..."

pip3 install --user -r "$DIR/python/requirements.txt"

python3 $DIR/bash/setup.py
python3 $DIR/git/setup.py
python3 $DIR/powershell/setup.py
python3 $DIR/ruby/setup.py
python3 $DIR/vim/setup.py

# if hash code 2>/dev/null; then
#   python3 $DIR/vscode/setup.py
# fi

python3 $DIR/zsh/setup.py

echo "Environment setup complete."
