local wezterm = require("wezterm")

return {
	{
		key = "f",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},

	-- Mac Nordic keyboard fix - START
	{
		key = "(",
		mods = "ALT|SHIFT",
		action = wezterm.action.SendString("{"),
	},
	{
		key = ")",
		mods = "ALT|SHIFT",
		action = wezterm.action.SendString("}"),
	},
	{
		key = "8",
		mods = "OPT",
		action = wezterm.action.SendString("["),
	},
	{
		key = "9",
		mods = "OPT",
		action = wezterm.action.SendString("]"),
	},
	{
		key = "/",
		mods = "ALT|SHIFT",
		action = wezterm.action.SendString("\\"),
	},
	{
		key = "7",
		mods = "OPT",
		action = wezterm.action.SendString("|"),
	},
}
