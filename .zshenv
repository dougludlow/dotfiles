# Minimal, shell-wide environment (safe for non-interactive shells)
# Keep this file lightweight: PATH and simple exports only.

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
	nvm use --silent >/dev/null 2>&1 || nvm use >/dev/null 2>&1
fi


# Ensure pnpm works in both login and non-login zsh shells.
if ! command -v pnpm >/dev/null 2>&1 && command -v corepack >/dev/null 2>&1; then
  pnpm() {
    corepack pnpm "$@"
  }
fi

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
