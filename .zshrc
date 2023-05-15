# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(aws brew docker git kubectl nvm nx-completion vscode yarn zsh-autosuggestions zsh-syntax-highlighting)

autoload -Uz compinit promptinit && compinit && promptinit
source $ZSH/oh-my-zsh.sh

if [[ $OSTYPE == 'darwin'* ]]; then
  # SSH
  ssh-add --apple-use-keychain -q

  export KUBE_EDITOR="code-insiders -w"
fi

# keys
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# pulumi
export PULUMI_SKIP_UPDATE_CHECK=true
if (( $+commands[pulumi] )); then
  source <(pulumi gen-completion zsh)
fi

# aws-sso-util
path+="$HOME/.local/bin"
if (( $+commands[aws-sso-util] )); then
  eval "$(_AWS_SSO_UTIL_COMPLETE=source_zsh aws-sso-util)"
fi

export AWS_DEFAULT_SSO_START_URL=https://d-9267707003.awsapps.com/start
export AWS_DEFAULT_SSO_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_PROFILE=nonprod

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
