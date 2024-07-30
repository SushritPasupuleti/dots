# Help for Octo.nvim

Allows using GH CLI to create and manage issues and PRs from within Neovim.

## 🚀 Usage

Just edit the issue title, body or comments as a regular buffer and use `:w(rite)` to sync the issue with GitHub.

## 🤖 Commands

There is only an `Octo <object> <action> [arguments]` command:
If no command is passed, the argument to `Octo` is treated as a URL from where an issue or pr repo and number are extracted

| Object | Action | Arguments|
|---|---|---|
| issue | close | Close the current issue|
| | reopen | Reopen the current issue|
| | create [repo]| Creates a new issue in the current or specified repo |
| | edit [repo] <number> | Edit issue `<number>` in current or specified repo |
| | list [repo] [key=value] (1) | List all issues satisfying given filter |
| | search | Live issue search |
| | reload | Reload issue. Same as doing `e!`|
| | browser | Open current issue in the browser |
| | url | Copies the URL of the current issue to the system clipboard|
| pr | list [repo] [key=value] (2)| List all PRs satisfying given filter |
| | search | Live issue search |
| | edit [repo] <number> | Edit PR `<number>` in current or specified repo|
| | reopen | Reopen the current PR|
| | create | Creates a new PR for the current branch|
| | close | Close the current PR|
| | checkout | Checkout PR|
| | commits | List all PR commits|
| | changes | Show all PR changes (diff hunks)|
| | diff | Show PR diff |
| | merge [commit\|rebase\|squash] [delete] | Merge current PR using the specified method|
| | ready| Mark a draft PR as ready for review |
| | checks | Show the status of all checks run on the PR |
| | reload | Reload PR. Same as doing `e!`|
| | browser | Open current PR in the browser|
| | url | Copies the URL of the current PR to the system clipboard|
| repo | list (3) | List repos user owns, contributes or belong to |
| | fork | Fork repo |
| | browser | Open current repo in the browser|
| | url | Copies the URL of the current repo to the system clipboard|
| | view | Open a repo by path ({organization}/{name})|
| gist | list [repo] [key=value] (4) | List user gists |
| comment | add | Add a new comment |
| | delete | Delete a comment |
| thread | resolve| Mark a review thread as resolved |
| | unresolve | Mark a review thread as unresolved |
| label | add [label] | Add a label from available label menu |
| | remove [label] | Remove a label |
| | create [label] | Create a new label |
| assignee| add [login] | Assign a user |
| | remove [login] | Unassign a user |
| reviewer | add [login] | Assign a PR reviewer |
| reaction | `thumbs_up` \| `+1` | Add 👍 reaction|
| | `thumbs_down` \| `-1` | Add 👎 reaction|
| | `eyes` | Add 👀 reaction|
| | `laugh` | Add 😄 reaction|
| | `confused` | Add 😕 reaction|
| | `rocket` | Add 🚀 reaction|
| | `heart` | Add ❤️ reaction|
| | `hooray` \| `party` \| `tada` | Add 🎉 reaction|
| card | add | Assign issue/PR to a project new card |
| | remove | Delete project card |
| | move | Move project card to different project/column|
| review| start| Start a new review |
| | submit| Submit the review |
| | resume| Edit a pending review for current PR |
| | discard| Deletes a pending review for current PR if any |
| | comments| View pending review comments |
| | commit | Pick a specific commit to review |
| | close | Close the review window and return to the PR |
| actions |  | Lists all available Octo actions|
| search | <query> | Search GitHub for issues and PRs matching the [query](https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests) |

0. `[repo]`: If repo is not provided, it will be derived from `<cwd>/.git/config`.

1. In-menu mappings:
- `<CR>`: Edit Issue
- `<C-b>`: Opens issue in the browser
- `<C-y>`: Copies URL to system clipboard

[Available filter keys](https://docs.github.com/en/free-pro-team@latest/graphql/reference/input-objects#issuefilters)
- since
- createdBy
- assignee
- mentioned
- labels
- milestone
- states


2. In-menu mappings:
- `<CR>`: Edit PR
- `<C-b>`: Opens PR in the browser
- `<C-o>`: Checkout PR
- `<C-y>`: Copies URL to system clipboard

[Available filter keys](https://github.com/pwntester/octo.nvim/blob/master/lua/octo/pickers/telescope/provider.lua#L34)
- baseRefName
- headRefName
- labels
- states

3. In-menu mappings:
- `<CR>`: View repo
- `<C-b>`: Opens repo in the browser
- `<C-y>`: Copies URL to system clipboard

4. In-menu mappings:
- `<CR>`: Append Gist to buffer
[Available keys](https://cli.github.com/manual/gh_gist_list):  `repo`\|`public`\|`secret`

## 🔥 Examples

```
Octo https://github.com/pwntester/octo.nvim/issues/12
Octo issue create
Octo issue create pwntester/octo.nvim
Octo comment add
Octo reaction add hooray
Octo issue edit pwntester/octo.nvim 1
Octo issue edit 1
Octo issue list createdBy=pwntester
Octo issue list neovim/neovim labels=bug,help\ wanted states=OPEN
Octo search assignee:pwntester is:pr
```

## 📋 PR review

- Open the PR (eg: `Octo <PR url>` or `Octo pr list` or `Octo pr edit <PR number>`)
- Start a review with `Octo review start` or resume a pending review with `Octo review resume`
- A new tab will show a panel with changed files and two windows showing the diff on any of them.
- Change panel entries with `]q` and `[q` or by selecting an entry in the window
- Add comments with `<space>ca` or suggestions with `<space>sa` on single or multiple visual-selected lines
  - A new buffer will appear in the alternate diff window. The cursor will be positioned in the new buffer
  - When ready, save the buffer to commit changes to GitHub
  - Move back to the diff window and move the cursor, the thread buffer will hide
- Hold the cursor on a line with a comment to show a thread buffer with all the thread comments
  - To modify, delete, react or reply to a comment, move to the window containing the thread buffer
  - Perform any operations as if you were in a regular issue buffer
- Review pending comments with `Octo review comments`
  - Use <CR> to jump to the selected pending comment
- If you want to review a specific commit, use `Octo review commit` to pick a commit. The file panel will get filtered to show only files changed by that commit. Any comments placed on these files will be applied at that specific commit level and will be added to the pending review.
- When ready, submit the review with `Octo review submit`
- A new float window will pop up. Enter the top level review comment and exit to normal mode. Then press `<C-m>` to submit a comment, `<C-a>` to approve it or `<C-r>` to request changes
