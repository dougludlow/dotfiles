#!/usr/bin/env bash

if [ ! -f "`which aws-sso-util`" ]; then
  echo '- installing aws-sso-util'
  brew install pipx
  pipx install aws-sso-util
fi

