# Fix lazy.nvim fetch timeouts and Roslyn/C# activation

## Objective

Make `lazy.nvim` plugin updates complete without fetch failures/timeouts while keeping SSH as the GitHub transport, and restore the C#/.NET language server (autocomplete, inlay hints, diagnostics) on Neovim 0.13-dev.

## Problem

1. `Lazy update` leaves all ~67 plugins stuck in `fetch`, then reports `fetch failed` or `Process was killed because it reached the timeout`.
2. Opening a `.cs`/.NET project does not start Roslyn; no completion or C#-specific LSP features.

## Why

- `~/.gitconfig` rewrites `https://github.com/` -> `git@github.com:` globally. SSH auth was verified working (`ssh -T git@github.com` => authenticated as `rpalaciosg`; a single `git fetch` over SSH completes in ~1.9 s). The user explicitly chose to KEEP SSH.
- `lazy.nvim` has `concurrency = nil` on Linux (unbounded) and `git.timeout = 120`. Launching ~67 simultaneous SSH git sessions against GitHub causes connection drops; slow ones are killed at 120 s.
- `lazy-lock.json` (pre-existing uncommitted change) bumps `roslyn.nvim` from `7d8c166` to `bf1bd4e`. `bf1bd4e` adds `--daemon-mode` to the server `cmd` and documents a minimum Roslyn server of `5.12.0-1.26453.19`. The installed Mason server is `5.8.0-1.26276.4` and rejects that flag (`lsp.log:18`: `Unrecognized command or argument '--daemon-mode'`).
- Mason registries are stale/corrupt (`registry.json.zip` missing, checksum verification failed in `mason.log`), so the server cannot be upgraded from Mason right now.

## Scope (authorized)

- `nvim/.config/nvim/lua/config/lazy.lua` — bound fetch concurrency and raise git timeout.
- `nvim/.config/nvim/lua/plugins/lsp/roslyn.lua` — override `cmd` to the documented daemon-mode opt-out so the installed 5.8 server starts.
- Work on branch `fix/lazy-fetch-roslyn`. Work-unit commits per task.

## Constraints

- Keep SSH transport. Do NOT change `~/.gitconfig`.
- Do NOT touch pre-existing uncommitted changes: `shell/aliases.sh`, `lazy-lock.json`, untracked `.atl/`, `modules/`, `tmux/plugins/tpm`.
- No remote push, PR, or merge; those remain the user's decision.
- Generated technical artifacts in English; user-facing chat in Spanish.

## Route declaration

- Route: delegated direct (one writer), triggered by the writer rule (2 non-trivial files) and the preparation rule.
- Exploration: one `explore` agent mapped the config; one `general` agent verified Roslyn version compatibility.
- Verification: per-action fresh checks by the parent; no SDD artifacts.

## TDD mode

- Source: repository `AGENTS.md` — "No build/test/lint — purely Lua config files."
- Effective mode: off/unavailable (no test runner configured). Do not invoke `sdd-init`.
- Functional checks still required (see below).

## Tasks

- [x] **T1 — Bound lazy git concurrency** (`lua/config/lazy.lua`)
  Set `concurrency = 4`, `git.timeout = 300`, and `checker.concurrency = 4`. Keeps SSH, avoids ~67 simultaneous SSH sessions and the 120 s kill.
  Check: headless config load exit 0; `Lazy! check` completed with 65/67 fetches OK over SSH; 2 plugins still hit intermittent port-22 timeouts.
  Commit: `0c23228 fix(nvim): bound lazy fetch concurrency`.

- [x] **T2 — Restore Roslyn with the installed server** (`lua/plugins/lsp/roslyn.lua`)
  Apply the `cmd` override from `init` (which runs before `vim.lsp.enable()` in the plugin script), resolve the Mason binary without requiring plugin modules, and omit `--daemon-mode` per the plugin's documented opt-out. Keep existing settings and `on_attach`.
  Check: headless fixture produced `ROSLYN_CLIENTS=1`, `COMPLETION=true`, and no new `--daemon-mode` rejection in `lsp.log`.
  Commits: `c05caa9 fix(nvim): start roslyn without daemon-mode flag`, then the follow-up `init`-timing correction.

## Acceptance criteria

- `Lazy update` finishes with no `fetch failed` and no timeout kills over SSH.
- Opening a C# project starts a `roslyn` LSP client with `completionProvider`, and `lsp.log` contains no `--daemon-mode` rejection.
- No changes to `~/.gitconfig` or the user's unrelated uncommitted files.

## Applicable checks

- `nvim --headless -c 'lua require("config.lazy")' -c qa` (config loads cleanly)
- `nvim --headless '+Lazy! update' +qa` (real update over SSH)
- Minimal C# fixture: `.csproj` + `.cs`; headless `vim.lsp.get_clients({ name = "roslyn" })` and `server_capabilities.completionProvider`
- `git diff --check` and `stylua --check` on edited Lua files if available

## Progress / verification evidence

- 2026-11-24: SSH auth verified (`Hi rpalaciosg! You've successfully authenticated`); single `git fetch` over SSH: exit 0 in 1.9 s.
- 2026-11-24: installed Roslyn binary `--version` = `5.8.0-1.26276.4+b1a4195`; `--help` has no `--daemon-mode`.
- 2026-11-24: old `roslyn.nvim` commit `7d8c166` used `cmd = { path, "--stdio" }` and no stated server floor; new `bf1bd4e` adds `--daemon-mode` and requires `>= 5.12.0-1.26453.19`.
- 2026-11-24: `ssh -T git@github.com` authenticated as `rpalaciosg`; SSH port 443 against `ssh.github.com` also authenticated with the same keys.
- 2026-11-24: config load `nvim --headless ...` exit 0; `Lazy! check` exit 0, 65/67 fetches OK, 2 intermittent port-22 timeouts (`nvim-treesitter`, `nvim-ts-autotag`).
- 2026-11-24: `stylua --check` and `git diff --check` clean on edited Lua files.
- 2026-11-24: first `config`-based `cmd` override was too late — `plugin/roslyn.lua` starts the client before lazy's `config` runs. Moved the override to `init`; headless fixture then reported 1 Roslyn client with completion capability and no new LSP error.

## Next step

Report results and remaining follow-ups: intermittent SSH port-22 timeouts (GitHub SSH over 443 is verified working and is the user's decision), Mason registry repair to allow a Roslyn server upgrade, `init.lua` autocmds module never invoked, and `diagnostics.lua` dead `is_active` guard.
