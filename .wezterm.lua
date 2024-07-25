-- Pull in wezterm api
local wezterm = require("wezterm")
local act = wezterm.action

-- Holds the configuration
local config = wezterm.config_builder()

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
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true

config.colors = {
	-- Cursor --
	cursor_bg = "#F5A97F",
	cursor_border = "#C6A0F6",
	cursor_fg = "#ED8796",
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#00FF00",

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#228B22",
			-- The color of the text for the tab
			fg_color = "#c0c0c0",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#FF4500",
			fg_color = "#FFFFFF",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 450

return config
