# AI workflows in this Neovim config

`<leader>` is `,` everywhere below (`vim.g.mapleader = ","`, set in `init.lua`).

Five tools are wired in, each doing a different job:

| Tool | What it's for | Owns |
|---|---|---|
| [Claude Code](#claude-code--claudecodenvim) | Agentic pairing, in-Neovim diff review | `<leader>cc*` |
| [OpenCode](#opencode--opencodenvim) | Agentic pairing, in-Neovim diff review | `<leader>o*` |
| [Copilot inline](#github-copilot-inline-completions--copilotlua) | Ghost-text completions as you type | automatic, `<M-]>` / `<M-[>` / `<S-Tab>` |
| [Sidekick NES](#next-edit-suggestions-nes--sidekicknvim) | Multi-line refactor suggestions (Copilot-powered) | `<Tab>` |
| [Sidekick CLI](#generic-cli-multiplexing--sidekicknvim) | Generic terminal multiplexing for any AI CLI | `<leader>a*` |

Claude Code and OpenCode each get a **native, editable Neovim diff buffer** before
anything is written to disk — that's the "VS Code-like" block-by-block review layer.
Everything else (Copilot CLI, Codex CLI) falls back to a simpler whole-file preview
via `code-preview.nvim`. See [Diff review model](#diff-review-model-code-previewnvim)
for why the split works this way and isn't duplicated across tools.

---

## Claude Code — `claudecode.nvim`

`coder/claudecode.nvim` — the same WebSocket/MCP "IDE integration" protocol used by
Anthropic's official VS Code/JetBrains extensions. Neovim runs a WebSocket server,
writes a lock file to `~/.claude/ide/*.lock`, and the `claude` CLI connects to it —
so Claude gets live access to open buffers, selections, and diagnostics, and routes
file edits through Neovim as a real diff instead of writing silently.

No manual setup needed — `<leader>cct` auto-starts the server and terminal on first use.

| Key | Mode | Action |
|---|---|---|
| `<leader>cct` | n | Toggle the Claude Code terminal (`:ClaudeCode`) |
| `<leader>ccf` | n | Focus the Claude Code terminal |
| `<leader>ccr` | n | Resume last conversation (`--resume`) |
| `<leader>ccC` | n | Continue last conversation (`--continue`) |
| `<leader>ccm` | n | Pick a model (`:ClaudeCodeSelectModel`) |
| `<leader>ccb` | n | Add current buffer to context |
| `<leader>ccs` | v | Send visual selection to Claude |
| `<leader>ccs` | n | Add file under cursor to context — only in `nvim-tree`/oil/netrw/etc. |
| `<leader>cca` | n | Accept the pending diff |
| `<leader>ccd` | n | Deny the pending diff |
| `<leader>ccx` | n | Close all pending diffs |

**Diff review** — when Claude proposes an edit, a real (editable) diff buffer opens
(`diff_opts.layout = "vertical"`):
- `]c` / `[c` — jump to next/previous changed hunk (native vim diff-mode)
- `do` / `dp` — pull/push an individual hunk between the two sides — this is the
  actual block-by-block accept/reject
- `:w` (or `<leader>cca`) — accept and save
- `:q` (or `<leader>ccd`) — reject and close

---

## OpenCode — `opencode.nvim`

`nickjvandyke/opencode.nvim` connects to an **already-running** `opencode` process —
it does not spawn one. Start one first:

```sh
opencode --port
```

Then `<leader>og` toggles the Neovim-side UI against it. Edits arrive via OpenCode's
own permission-events (SSE), configured in `opencode/opencode.json` with
`"edit": "ask"` — that's what makes OpenCode pause and hand the diff to Neovim instead
of just writing the file.

| Key | Mode | Action |
|---|---|---|
| `<leader>og` | n, t | Toggle OpenCode UI |
| `<leader>oa` | n, x | Ask (`@this: ` prefilled) |
| `<leader>os` | n, x | Select action |
| `<leader>oo` | n, x | Add range as context (operator, `@this`) |
| `<leader>ol` | n | Add current line as context |
| `<leader>on` | n | New session |
| `<leader>oS` | n | Select session |
| `<leader>oi` | n | Interrupt |
| `<leader>oc` | n | Compact session |
| `<leader>ou` / `<leader>od` | n | Scroll output up / down |
| `<leader>oz` / `<leader>or` | n | Undo / redo last agent action |
| `<leader>oA` | n | Cycle agent |
| `<a-a>` | snacks picker | Send picker selection to OpenCode |

**Diff review** — OpenCode's proposed edit opens in a new tab via `:diffpatch`,
genuinely hunk-level, same vim diff-mode primitives:
- `dp` — accept the hunk under the cursor
- `do` — reject the hunk under the cursor
- `da` — accept the entire edit
- `dr` — reject the entire edit

---

## GitHub Copilot inline completions — `copilot.lua`

Ghost-text completions, always on for the filetypes listed in
`lua/sushrit_lawliet/copilot.lua` (`auto_trigger = true`).

| Key | Action |
|---|---|
| `<S-Tab>` | Accept suggestion |
| `<A-S-Tab>` | Accept just the current line |
| `<M-]>` | Next suggestion |
| `<M-[>` | Previous suggestion |
| `<C-]>` | Dismiss |

`copilot-status.nvim` shows idle/loading/error/offline as a statusline icon — no
keymaps, purely a status indicator for the above.

---

## Next Edit Suggestions (NES) — `sidekick.nvim`

Separate from the ghost-text above: NES watches for typing pauses / cursor moves and
suggests **entire multi-line refactorings** anywhere in the file (not just at the
cursor), powered by the Copilot LSP server (needs the same Copilot subscription,
Neovim ≥ 0.11.2).

| Key | Mode | Action |
|---|---|---|
| `<Tab>` | n, i | Jump to the next suggested edit, or apply it if already on it (falls back to a literal Tab if there's nothing pending) |

---

## Generic CLI multiplexing — `sidekick.nvim`

For everything that isn't Claude Code or OpenCode — right now that's the Copilot CLI,
but the same commands work with any of sidekick's ~12 pre-configured tools. Sessions
persist in `tmux` panes (`cli.mux.backend = "tmux"`), so they survive a Neovim
restart.

| Key | Mode | Action |
|---|---|---|
| `<leader>aa` | n | Toggle the last-used/default CLI |
| `<leader>as` | n | Select which CLI to start or attach to |
| `<leader>ad` | n | Detach the current CLI session |
| `<leader>ag` | n | Toggle Copilot CLI specifically |
| `<leader>at` | n, x | Send "this" (line/context) to the active CLI |
| `<leader>af` | n | Send the current file |
| `<leader>av` | x | Send the visual selection |
| `<leader>ap` | n, x | Pick a pre-defined (or custom) prompt to send |
| `<c-.>` | n, t, i, x | Focus the active CLI terminal |

Claude Code deliberately has **no** entry here (no `<leader>ac`) — it's fully owned by
`claudecode.nvim` above, since that integration gives native diff review that a bare
tmux pane can't.

---

## Diff review model (`code-preview.nvim`)

`Cannon07/code-preview.nvim` is a generic, hook-based "preview any agent's edit as a
Neovim diff before it's written" plugin, supporting Claude Code, OpenCode, Copilot
CLI, and Codex CLI. It's now scoped to **Copilot CLI only** — installed via
`.github/hooks/code-preview.json`.

Claude Code and OpenCode used to also run through it, but both were uninstalled
(`:CodePreviewUninstallClaudeCodeHooks`, `:CodePreviewUninstallOpenCodeHooks`) in
favor of their own native, richer integrations above — running both at once risked
two diff popups per edit. Copilot CLI has no native equivalent, so it's still the
only backend that uses this plugin.

Its review model is intentionally simpler than Claude Code/OpenCode's: the diff
buffer is **read-only**, and accept/reject actually happens back in the Copilot CLI's
own prompt — Neovim is a preview surface, not a decision surface, for this one.

| Key | Scope | Action |
|---|---|---|
| `]c` / `[c` | inline diff buffer | Jump to next/previous changed line |
| `<leader>dq` | global | Close the diff and clear pending-change indicators |

Useful commands: `:CodePreviewStatus`, `:CodePreviewCloseDiff`,
`:checkhealth code-preview`.

---

## Present but dormant

Two AI plugins are still declared in `init.lua` with `enabled = false` — kept around
rather than deleted, in case they're revisited:

- **`olimorris/codecompanion.nvim`** (`lua/sushrit_lawliet/agent.lua`) — chat/inline
  assistant wired to the Copilot adapter, with an `mcphub.nvim` extension for MCP
  server tools. Superseded by Claude Code/OpenCode for anything agentic.
- **`CopilotC-Nvim/CopilotChat.nvim`** — Copilot-backed chat sidebar. Superseded by
  the same.
