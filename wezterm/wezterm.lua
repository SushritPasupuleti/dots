local wezterm = require 'wezterm'

return {
	color_scheme = 'Catppuccin Mocha',
	font = wezterm.font 'Fira Code',
	font_size = 14.0,
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	freetype_load_target = 'Light',
	use_fancy_tab_bar = false,
	enable_tab_bar = false,
	window_background_opacity = 0.95,
}
