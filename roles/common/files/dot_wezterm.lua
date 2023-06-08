local wezterm = require 'wezterm'
local config = {}
local act = wezterm.action

--
-- Appearance
--

config.color_scheme = 'Dark+'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13
config.warn_about_missing_glyphs = false

config.keys = {
  {
    key = 'r',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal {domain = "CurrentPaneDomain"},
  },
  {
    key = 'd',
    mods = 'CTRL|ALT',
    action = act.SplitVertical {domain = "CurrentPaneDomain"},
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize {"Left", 1},
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize {"Right", 1},
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize {"Up", 1},
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize {"Down", 1},
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
      act.SpawnCommandInNewTab {
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

wezterm.on('window-focus-changed', function(window, pane)
  if window:is_focused() then
    local has_selection = window:get_selection_text_for_pane(pane) ~= ''

    if has_selection then
      window:perform_action(act.ClearSelection, pane)
    end
  end
end)

return config
