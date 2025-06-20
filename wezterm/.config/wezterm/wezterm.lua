-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "carbonfox"
config.font = wezterm.font("SauceCodePro Nerd Font Mono")
config.enable_tab_bar = false
config.window_background_opacity = 0.9

config.window_padding = {
	left = "0.25cell",
	right = "0.25cell",
	top = "0.25cell",
	bottom = "0.25cell",
}
-- Finally, return the configuration to wezterm:
return config
