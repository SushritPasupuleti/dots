local browse = require("browse")

local bookmarks = {
	"https://google.com",
}

vim.keymap.set("n", "<leader>b", function()
	require("browse").browse({ bookmarks = bookmarks })
end)

function command(name, rhs, opts)
	opts = opts or {}
	vim.api.nvim_create_user_command(name, rhs, opts)
end

command("BrowseInputSearch", function()
	browse.input_search()
end, {})

command("Browse", function()
	browse.browse({ bookmarks = bookmarks })
end, {})

command("BrowseBookmarks", function()
	browse.open_bookmarks({ bookmarks = bookmarks })
end, {})

command("BrowseDevdocsSearch", function()
	browse.devdocs.search()
end, {})

command("BrowseDevdocsFiletypeSearch", function()
	browse.devdocs.search_with_filetype()
end, {})

command("BrowseMdnSearch", function()
	browse.mdn.search()
end, {})

-- URL Viewer

require("urlview").setup({
	-- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
	default_title = "Links:",
	-- Default picker to display links with
	-- Options: "native" (vim.ui.select) or "telescope"
	default_picker = "telescope",
	-- Set the default protocol for us to prefix URLs with if they don't start with http/https
	default_prefix = "https://",
	-- Command or method to open links with
	-- Options: "netrw", "system" (default OS browser); or "firefox", "chromium" etc.
	default_action = "system",
	-- Ensure links shown in the picker are unique (no duplicates)
	unique = true,
	-- Ensure links shown in the picker are sorted alphabetically
	sorted = true,
	-- Logs user warnings (recommended for error detection)
	-- debug = true,
	-- Custom search captures
	-- NOTE: captures follow Lua pattern matching (https://riptutorial.com/lua/example/20315/lua-pattern-matching)
	custom_searches = {
		-- KEY: search source name
		-- VALUE: custom search function or table (map with keys capture, format)
		jira = {
			capture = "AXIE%-%d+",
			format = "https://jira.axieax.com/browse/%s",
		},
	},
})
