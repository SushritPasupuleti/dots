local wezterm = require("wezterm")

return {
	enable_wayland = true,
	-- front_end = 'WebGpu', -- To work with Wayland + Nvidia
	--macos
	macos_window_background_blur = 20,
	--macOS End
	color_scheme = "Catppuccin Mocha",
	-- font = wezterm.font("Fira Code"),
	warn_about_missing_glyphs = false,
	underline_position = -4,
	font = wezterm.font({
		family = "Monaspace Neon",
		weight = "Regular",
		-- harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
	}),
	font_rules = {
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 500,
			}),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 500,
				italic = true,
			}),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 700,
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 700,
				italic = true,
			}),
		},
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 300,
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				-- family = "Fira Code",
				family = "Monaspace Neon",
				weight = 300,
				italic = true,
			}),
		},
	},
	font_size = 14.0,
	harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	freetype_load_target = "Light",
	use_fancy_tab_bar = false,
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	tab_max_width = 128,
	window_background_opacity = 0.85,
	window_decorations = "NONE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	colors = {
		background = "#0f1117",
	},
	window_frame = {
		border_left_width = "0",
		border_right_width = "0",
		border_bottom_height = "0",
		border_top_height = "0",
		-- border_left_color = "purple",
		-- border_right_color = "purple",
		-- border_bottom_color = "purple",
		-- border_top_color = "purple",
	},
	-- enable_scroll_bar = true,
	keys = {
		{
			--CTRL + SHIFT + P
			key = "P",
			mods = "CTRL",
			action = wezterm.action.ActivateCommandPalette,
		},
		{
			--ALT + L
			key = "l",
			mods = "ALT",
			action = wezterm.action.ShowLauncher,
		},
	},
	launch_menu = {
		{
			args = { "btop" },
			label = "btop",
		},
		{
			args = { "sudo", "openrgb" },
			label = "OpenRGB",
		},
	},
	command_palette_bg_color = "#1e1e2e",
	audible_bell = "Disabled",
}
