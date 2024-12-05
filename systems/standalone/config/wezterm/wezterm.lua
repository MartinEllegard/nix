local wezterm = require("wezterm")

local theme = os.getenv("THEME") or "gruvbox"

return {
	color_scheme = "Gruvbox dark, medium (base16)",
	enable_tab_bar = false,
	font_size = 13.0,

	macos_window_background_blur = 30,
	window_background_opacity = 0.78,
	window_decorations = "RESIZE",
	enable_wayland = true,

	keys = require("keybindings-mac"),

	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
