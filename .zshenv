# Minimal, shell-wide environment (safe for non-interactive shells)
# Keep this file lightweight: PATH and simple exports only.


path+=(
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/opt/homebrew/opt/libpq/bin"
)

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh" --no-use
	# Prefer a local .nvmrc; nvm's auto-use checks the default alias first.
	nvm use --silent >/dev/null 2>&1 || nvm use --silent default >/dev/null 2>&1 || true
fi

# Ensure pnpm works in both login and non-login zsh shells.
if ! command -v pnpm >/dev/null 2>&1 && command -v corepack >/dev/null 2>&1; then
  pnpm() {
    corepack pnpm "$@"
  }
fi
