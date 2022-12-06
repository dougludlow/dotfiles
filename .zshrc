# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
VSCODE=code-insiders

plugins=(aws brew docker git kubectl nvm nx-completion pyenv rbenv vscode yarn zsh-autosuggestions zsh-syntax-highlighting)

source <(pulumi gen-completion zsh)

fpath=(~/.zsh/completions $fpath)
autoload -U compinit promptinit && compinit && promptinit
zmodload -i zsh/complist

source $ZSH/oh-my-zsh.sh

# SSH
ssh-add --apple-use-keychain -q

# Add Visual Studio Code (code)
path+="/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
export KUBE_EDITOR="code -w"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
