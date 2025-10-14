-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 15
config.color_scheme = "Everforest Dark (Gogh)"

return config
