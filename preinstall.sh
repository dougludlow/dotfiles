#!/usr/bin/env bash

# Check if Homebrew is installed
if [ ! -f "`which brew`" ]; then
  echo '- installing homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo '- updating homebrew'
  brew update
fi

# Install Homebrew Bundle
brew tap homebrew/bundle

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo '- installing oh-my-zsh'
  /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Change default shell
if [[ ! $SHELL =~ "zsh" ]]; then
  echo '- changing default shell to zsh'
  chsh -s /bin/zsh
fi
