local wezterm = require("wezterm")

local theme = os.getenv("THEME") or "gruvbox"
if theme == "catppuccin" then
	theme = "Catppuccin Mocha"
elseif theme == "gruvbox" then
	theme = "Gruvbox dark, medium (base16)"
end

local transparency = os.getenv("TRANSPARENCY") or "true"
local opacity = 1.0
if transparency == "true" then
	opacity = 0.95
else
	opacity = 1.0
end

return {
	color_scheme = theme,
	-- color_scheme = "Gruvbox dark, medium (base16)",
	-- color_scheme = "Tokyo Night",
	-- color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 15.0,

	macos_window_background_blur = 30,
	-- Transparent background
	window_background_opacity = opacity,
	window_decorations = "RESIZE",

	keys = require("safe-keybindings-mac"),

	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
