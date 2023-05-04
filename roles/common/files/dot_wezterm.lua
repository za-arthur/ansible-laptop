local wezterm = require 'wezterm'
local config = {}

--
-- Appearance
--

config.color_scheme = 'Dark+'

config.font = wezterm.font 'Hack'
config.font_size = 13

config.keys = {
  {
    key = 'r',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitHorizontal {domain = "CurrentPaneDomain"},
  },
  {
    key = 'd',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitVertical {domain = "CurrentPaneDomain"},
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize {"Left", 1},
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize {"Right", 1},
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize {"Up", 1},
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize {"Down", 1},
  },
}

config.window_decorations = "RESIZE"

--
-- Handle events
--

-- Use the defaults as a base
wezterm.on('open-uri', function(window, pane, uri)
  local start, match_end = uri:find 'pid:'
  if start == 1 then
    local pid = uri:sub(match_end + 1)
    window:perform_action(
      wezterm.action.SpawnCommandInNewTab {
        args = { 'gdb', '-p', pid },
      },
      pane
    )
    -- prevent the default action from opening in a browser
    return false
  end
  -- otherwise, by not specifying a return value, we allow later
  -- handlers and ultimately the default action to caused the
  -- URI to be opened in the browser
end)

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
  regex = 'pid:\\d+',
  format = '$0',
})

return config
