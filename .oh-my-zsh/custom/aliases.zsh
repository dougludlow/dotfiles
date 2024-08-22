# docker compose
alias dc="docker compose"
alias dcb="dc build"
alias dcd="dc down"
alias dce="dc exec"
alias dcl="dc logs -f"
alias dcp="dc ps"
alias dcr="dc run --rm"
alias dcu="dc up -d"
alias dcrm="dc rm -f -s -v"

function dcrb {
  dcrm $@ && dcb $@ && dcu $@
}

function dcrs {
  dcrm $@ && dcu $@
}

# kubernetes
alias k="kubectl"

# pulumi
alias p="pulumi"
alias pu="pulumi up"
alias ppr="pulumi preview"
alias pss="pulumi stack select"

# code
# alias code="code-insiders"

# utilities
function killport {
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9
}
