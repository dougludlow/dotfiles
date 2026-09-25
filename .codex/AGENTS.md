## Subagent preferences

When using subagents, prefer gpt-6-luna with xhigh reasoning effort (Extra High) whenever available and suitable for the task. Use a more capable model when the task requires it.

## Branch Naming

Always use a descriptive git branch name: `{feat|fix|chore}/se-XXXX-short-slug` when a Linear ticket exists, otherwise `{feat|fix|chore}/short-slug`. Ticket id lowercase, immediately after the slash. Never keep or create auto-generated branch names (cursor/<hash>, codex/<timestamp>, copilot/<id>, bare username prefixes) — if a session starts on one, create or rename to a properly named branch before the first commit.

## Pull Requests

Always use the /create-pr skill when creating pull requests. Never mark a pull request ready for review without my explicit approval. Open PRs as drafts and leave them as drafts. Completed work, green CI, and a clean self-review are not permission to mark it ready. Only an explicit instruction from me in the current conversation is. If you believe a PR is ready, say so and let me flip it myself.

## Conventional Commits

Use Conventional Commits for git commits: `type(scope): imperative subject`, subject <= 72 characters, no trailing period. Types: feat, fix, refactor, test, docs, chore, revert. Scope is required unless the change is genuinely repo-wide. When a Linear ticket applies, append the id to the subject, e.g. `fix(integrations): clear stale enterprise ids (SE-1816)`.