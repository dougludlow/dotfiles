#!/usr/bin/env bash

git submodule add https://github.com/anishathalye/dotbot.git dotbot
git submodule add https://github.com/jscutlery/nx-completion.git .oh-my-zsh/custom/plugins/nx-completion
git submodule add https://github.com/zsh-users/zsh-autosuggestions.git .oh-my-zsh/custom/plugins/zsh-autosuggestions
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git submodule add https://github.com/romkatv/powerlevel10k.git .oh-my-zsh/custom/themes/powerlevel10k

git config -f .gitmodules submodule.dotbot.ignore dirty
git config -f .gitmodules submodule..oh-my-zsh/custom/plugins/nx-completion.ignore dirty
git config -f .gitmodules submodule..oh-my-zsh/custom/plugins/zsh-autosuggestions dirty
git config -f .gitmodules submodule..oh-my-zsh/custom/plugins/zsh-syntax-highlighting.ignore dirty
git config -f .gitmodules submodule..oh-my-zsh/custom/themes/powerlevel10k.ignore dirty
