# AGENTS.md — dotfiles (`rpalaciosg/dotfiles`)

## Repo structure

Dotfiles managed with **GNU Stow**. Each top-level dir is a stow package.

```
nvim/     → ~/.config/nvim
tmux/     → ~/.config/tmux
shell/    → $HOME (aliases.sh sourced from .zshrc)
modules/  → used by zsh (zimfw), not stowed independently
```

Apply all symlinks: `stow .` (from repo root).
Remove symlinks: `stow -D .`.
Add a new package: create dir mirroring home path, then `stow <dir>`.
All paths in the repo mirror `$HOME` — files at `nvim/.config/nvim/...` = `~/.config/nvim/...` after stow.

## Neovim (`nvim/.config/nvim`)

- **LazyVim-inspired** structure. Bootstraps `lazy.nvim` at `lua/config/lazy.lua`.
- **Dual-mode**: standalone or inside VSCode (`vim.g.vscode` check in `init.lua:6`). VSCode mode skips lazy plugin loading and uses `lua/config/vscode.lua` for keymaps.
- Entrypoint: `init.lua` → loads `config.{options,keymaps,autocmds}`, then `config.lazy` (standalone only).
- Plugin imports guarded by VSCode check at `lua/config/lazy.lua:36` — `plugins/{init,coding,lsp}` only load outside VSCode.
- Plugin specs live under `lua/plugins/`:
  - `plugins/init.lua` — core (plenary, vim-tmux-navigator, coding+ui imports)
  - `plugins/coding/` — coding tools, DAP, treesitter, telescope, harpoon, gitsigns, substitute, flash.nvim, todo-comments, mini.* (ai, surround, comment, move, pairs, trailspace)
  - `plugins/ui/` — colorscheme (sonokai), lualine, neo-tree, which-key v3, incline, alpha, snacks, auto-session
  - `plugins/lsp/` — mason + mason-lspconfig + mason-tool-installer + nvim-lspconfig (uses `vim.lsp.config` API, not lspconfig.setup)
- **No build/test/lint** — purely Lua config files.
- Formatting: stylua (2 spaces, 100 col width) at `stylua.toml`.
- LSP servers auto-installed by mason: lua_ls, ts_ls, html, cssls, tailwindcss, svelte, graphql, emmet_ls, prismals, pyright, eslint, jsonls, dockerls, yamlls.
- Formatters/linters auto-installed: prettier, stylua, pylint, isort, black, eslint_d, js-debug-adapter, roslyn.
- Keymaps registered centrally in `lua/config/whichkey_labels.lua` (which-key v3 `wk.add`). LSP on-attach keymaps in `lua/config/lsponattach.lua`.
- C# support via Roslyn at `plugins/lsp/roslyn.lua`.
- Verify nvim config: `nvim --headless "+Lazy! sync" +qa` or just open nvim.

## Tmux (`tmux/.config/tmux`)

- Prefix: `C-d` (not `C-b`).
- Plugins via TPM: vim-tmux-navigator, resurrect (+continuum), tmux-window-name.
- `.gitignore` excludes `plugins/` — installed at runtime by TPM (not a proper git submodule).
- Reload config: `<prefix> r` maps to `source-file ~/.config/tmux/tmux.conf`.

## Zsh (via `modules/dotly/modules/zimfw`)

- Uses **Zim** framework (repo at `modules/dotly/modules/zimfw/`).
- `.zimrc` lives at `$HOME/.zimrc` (not in repo). Edit it there, then run `zimfw build` to regenerate `modules/dotly/modules/zimfw/init.zsh`.
- Active modules (from `init.zsh`): environment, git, input, termtitle, utility, run-help, fzf, duration-info, completion, zsh-syntax-highlighting, zsh-history-substring-search, zsh-autosuggestions, bira theme.
- `shell/aliases.sh` is stowed to `$HOME/aliases.sh` and should be sourced from `.zshrc`.

## Git

- Remote: `git@github.com:rpalaciosg/dotfiles.git`
- No `.gitconfig` stow package yet.

## Common tasks

- Edit config files directly — no build, test, lint, or typecheck step.
- To reload tmux: `tmux source-file ~/.config/tmux/tmux.conf`.
- To rebuild zsh init: edit `~/.zimrc`, then run `zimfw build`.
- Reload aliases: `source ~/.aliases.sh`.
