-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Book", stretch = "Expanded" })
config.font_size = 16
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9
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
}

config.enable_tab_bar = false
-- https://github.com/ianyh/Amethyst/issues/1481
config.window_decorations = "RESIZE"

return config
