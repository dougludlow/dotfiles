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

  export GPG_TTY=$(tty)
  export KUBE_EDITOR="code-insiders -w"
fi

# keys
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# direnv
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# pulumi
export PULUMI_SKIP_UPDATE_CHECK=true
if (( $+commands[pulumi] )); then
  source <(pulumi gen-completion zsh)
fi

export PULUMI_CONFIG_PASSPHRASE=swell

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

# bun completions
[ -s "/Users/doug.ludlow/.bun/_bun" ] && source "/Users/doug.ludlow/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/doug.ludlow/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#compdef pnpm
###-begin-pnpm-completion-###
if type compdef &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }
  # When called by the Zsh completion system, this will end with
  # "loadautofunc" when initially autoloaded and "shfunc" later on, otherwise,
  # the script was "eval"-ed so use "compdef" to register it with the
  # completion system
  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi
###-end-pnpm-completion-###
