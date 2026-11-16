#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo install -d -m 755 /etc/codex
sudo ln -sfn "${BASEDIR}/.codex/requirements.toml" /etc/codex/requirements.toml
