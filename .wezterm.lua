-- Pull in wezterm api
local wezterm = require("wezterm")
local act = wezterm.action

-- Holds the configuration
local config = wezterm.config_builder()

-- SSH --
config.ssh_domains = {
	{
		name = "lab",
		remote_address = "192.168.0.16",
		username = "root",
	},
}

-- Remap copymode key binds --
if wezterm.gui then
	-- Initialize key_tables if it doesn't exist
	config.key_tables = config.key_tables or {}

	-- Initialize copy_mode table if it doesn't exist
	config.key_tables.copy_mode = config.key_tables.copy_mode or wezterm.gui.default_key_tables().copy_mode

	-- Insert new key bindings
	table.insert(config.key_tables.copy_mode, {
		key = "Backspace",
		mods = "NONE",
		action = act.CopyMode("MoveLeft"),
	})
	table.insert(config.key_tables.copy_mode, {
		key = "x",
		mods = "ALT",
		action = act.CopyMode({ SetSelectionMode = "Block" }),
	})
end

-- Set color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font
config.font = wezterm.font("MonaspiceKr Nerd Font")
config.font_size = 19.0

-- Key binds
config.keys = {

	{
		key = "LeftArrow",
		mods = "SHIFT|SUPER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|SUPER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "SHIFT|SUPER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "SHIFT|SUPER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		-- Remap ActivateCopyMode --
		key = "z",
		mods = "ALT",
		action = wezterm.action.ActivateCopyMode,
	},
}

-- Window settings
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.87
config.macos_window_background_blur = 9
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = "40px",
	right = "40px",
	top = "40px",
	bottom = "40px",
}

-- Window size
config.initial_cols = 200
config.initial_rows = 300

-- Tab Bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false

config.colors = {
	-- Cursor --
	cursor_bg = "rgba(245, 169, 127, 0.1)",
	cursor_border = "rgba(198, 160, 246, 0.1)",
	cursor_fg = "rgba(237, 135, 150, 0.1)",
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 450

return config
