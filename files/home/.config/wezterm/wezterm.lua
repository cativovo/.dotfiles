-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Light" })
config.font_size = 14
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.94
-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.disable_default_key_bindings = true
config.keys = {
	-- copy/paste
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = "IncreaseFontSize",
	},
	-- ctrl shift -
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = "DecreaseFontSize",
	},
	-- ctrl shift 0
	{
		key = ")",
		mods = "CTRL|SHIFT",
		action = "ResetFontSize",
	},
}

config.enable_tab_bar = false
config.window_decorations = "NONE"

return config
