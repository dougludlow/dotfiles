## Code organization

In classes, place private/helper methods **below** public methods, not above. Private methods sit "below the fold" so the public API is what a reader sees first when scanning the file.

## Comments

Default to no comments. Make code self-documenting through clear naming and structure. Only comment when the WHY is non-obvious (hidden constraint, subtle invariant, workaround for a specific bug). Don't write narration that restates what the code does — improve the naming instead.

## Branch Naming

Always use a descriptive git branch name: `{feat|fix|chore}/se-XXXX-short-slug` when a Linear ticket exists, otherwise `{feat|fix|chore}/short-slug`. Ticket id lowercase, immediately after the slash. Never keep or create auto-generated branch names (cursor/<hash>, codex/<timestamp>, copilot/<id>, claude/<slug>, bare username prefixes) — if a session starts on one, create or rename to a properly named branch before the first commit.

## Pull Requests

Always use the `create-pr` skill when creating pull requests (`$create-pr` in Codex, `/create-pr` in Claude Code). Use Conventional Commits for PR titles. Open PRs as drafts and leave them as drafts. Completed work, green CI, and a clean self-review are not permission to mark it ready. My personal review is required before marking a PR as ready and I will do that myself.

In Codex, after creating or updating a pull request, attach it to the current Codex chat and verify the attachment before finishing.

Comment with `@codex review` after creating the draft pull request to trigger a code review. Trigger additional code reviews on the same pull request only when significant changes are made.

After creating the draft pull request and requesting a code review, run the `babysit` skill to monitor CI and review feedback until the skill's stop condition is met.

## Conventional Commits

Use Conventional Commits for git commits: `type(scope): imperative subject`, subject <= 72 characters, no trailing period. Types: feat, fix, refactor, test, docs, chore, revert. Scope is required unless the change is genuinely repo-wide. When a Linear ticket applies, append the id to the subject, e.g. `fix(integrations): clear stale enterprise ids (SE-1816)`.

## Research and documentation output

Return research, explanations, suggestions, and plans in chat unless I explicitly request a saved artifact. Do not create repository documentation merely because a skill requires saving its output. This preference overrides skill instructions about output location.
