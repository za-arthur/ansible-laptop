local wezterm = require 'wezterm'
local config = {}
local act = wezterm.action

--
-- Appearance
--

config.front_end = "Software"

config.color_scheme = 'Dark+'

config.font_size = 14
config.line_height = 0.95

config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
  'Hack'
}
config.warn_about_missing_glyphs = false

config.keys = {
  {
    key = 'd',
    mods = 'SUPER',
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = 'd',
    mods = 'SHIFT|SUPER',
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize { "Left", 1 },
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize { "Right", 1 },
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize { "Up", 1 },
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT|ALT',
    action = act.AdjustPaneSize { "Down", 1 },
  },
}

config.show_new_tab_button_in_tab_bar = false

--
-- Handle events
--

-- Clean up selection on tab focus
wezterm.on('window-focus-changed', function(window, pane)
  if window:is_focused() then
    local has_selection = window:get_selection_text_for_pane(pane) ~= ''

    if has_selection then
      window:perform_action(act.ClearSelection, pane)
    end
  end
end)

-- Handle tab title
local process_icons = {
  ['docker'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['docker-compose'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['vim'] = {
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ['vim.basic'] = {
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ['hx'] = {
    { Text = wezterm.nerdfonts.dev_visualstudio },
  },
  ['nvim'] = {
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ['zsh'] = {
    { Text = wezterm.nerdfonts.cod_terminal },
  },
  ['bash'] = {
    { Text = wezterm.nerdfonts.cod_terminal_bash },
  },
  ['htop'] = {
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ['go'] = {
    { Text = wezterm.nerdfonts.mdi_language_go },
  },
  ['git'] = {
    { Text = wezterm.nerdfonts.dev_git },
  },
  ['lazygit'] = {
    { Text = wezterm.nerdfonts.dev_git_merge },
  },
  ['wget'] = {
    { Text = wezterm.nerdfonts.mdi_arrow_down_box },
  },
  ['curl'] = {
    { Text = wezterm.nerdfonts.mdi_flattr },
  },
  ['ssh'] = {
    { Text = wezterm.nerdfonts.cod_remote },
  },
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

  return (current_dir == HOME_DIR and '.')
      or (current_dir ~= nil and string.gsub(current_dir.path, '(.*[/\\])(.*)', '%2'))
end

local function get_process_title(process_name)
  return wezterm.format(
    process_icons[process_name]
    or { { Text = string.format('%s', process_name) } }
  )
end

wezterm.on(
  'format-tab-title',
  function(tab, _, _, _, _, _)
    local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
    local title = ''

    -- Show default title for ssh
    if process_name == 'ssh' then
      title = string.format(' %s  %s ', get_process_title(process_name), tab.active_pane.title)
    else
      title = string.format(' %s  %s ', get_process_title(process_name), get_current_working_dir(tab))
    end

    return {
      { Text = title },
    }
  end
)

return config
