# Minimal, shell-wide environment (safe for non-interactive shells)
# Keep this file lightweight: PATH and simple exports only.

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
	nvm use --silent >/dev/null 2>&1 || nvm use >/dev/null 2>&1
fi

