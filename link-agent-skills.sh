#!/usr/bin/env bash
# Links skills from local skill repositories into ~/.agents/skills.
# Skills installed by the skills CLI are restored from ~/.agents/.skill-lock.json instead.
set -euo pipefail

target="$HOME/.agents/skills"
repositories=(
  "$HOME/Source/dougludlow/skills"
  "$HOME/Source/swell/swell-skills"
)

mkdir -p "$target"

for repository in "${repositories[@]}"; do
  if [[ ! -d "$repository/skills" ]]; then
    echo "Skipping $repository (not cloned)"
    continue
  fi
  for skill in "$repository"/skills/*/; do
    skill="${skill%/}"
    link="$target/$(basename "$skill")"
    if [[ -e "$link" && ! -L "$link" ]]; then
      echo "Skipping $(basename "$skill"): $link exists and is not a symlink"
      continue
    fi
    ln -sfn "$skill" "$link"
  done
done
