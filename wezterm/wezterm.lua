-- Used the following as a inspiration https://alexplescan.com/posts/2024/08/10/wezterm/
-- Lua learning: https://www.lua.org/start.html
-- Import the wezterm module
local wezterm = require("wezterm")
-- Import our new module (put this near the top of your wezterm.lua)
local appearance = require("appearance")
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

if appearance.is_dark() then
	config.color_scheme = "Catppuccin Macchiato"
else
	config.color_scheme = "Catppuccin Latte"
end
config.font_size = 13

--
-- Slightly transparent and blurred background
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = "RESIZE"
-- Do not use the fancy tab bar, as it does not follow the color_scheme
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

wezterm.on("update-status", function(window, pane)
	-- Grab the utf8 character for the "powerline" left facing
	-- solid arrow.
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Grab the current window's configuration, and from it the
	-- palette (this is the combination of your chosen colour scheme
	-- including any overrides).
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	local cwd = ""
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
		end
	end

	window:set_right_status(wezterm.format({
		-- First, we draw the arrow...
		{ Background = { Color = "none" } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		-- Then we draw our text
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. cwd .. " " },
	}))
end)

------ Maping keys

--- Fix no PATH when starting from Finger
---   No viable candidates found in PATH "/usr/bin:/bin:/usr/sbin:/sbin"
config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

-- Table mapping keypresses to actions
config.keys = {
	-- Sends ESC + b and ESC + f sequence, which is used
	-- for telling your shell to jump back/forward.
	{
		-- When the left arrow is pressed
		key = "LeftArrow",
		-- With the "Option" key modifier held down
		mods = "OPT",
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	},
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},
}

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
