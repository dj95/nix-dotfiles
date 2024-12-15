{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    aerospace
    jankyborders
    sketchybar
  ];

  xdg.configFile."aerospace/aerospace.toml".text = ''
# Place a copy of this config to ~/.aerospace.toml
# After that, you can edit ~/.aerospace.toml to your liking

# It's not necessary to copy all keys to your config.
# If the key is missing in your config, "default-config.toml" will serve as a fallback

# You can use it to add commands that run after login to macOS user session.
# 'start-at-login' needs to be 'true' for 'after-login-command' to work
# Available commands: https://nikitabobko.github.io/AeroSpace/commands
after-login-command = []

# You can use it to add commands that run after AeroSpace startup.
# 'after-startup-command' is run after 'after-login-command'
# Available commands : https://nikitabobko.github.io/AeroSpace/commands
after-startup-command = [
  'exec-and-forget ${pkgs.fish}/bin/fish -c ${pkgs.sketchybar}/bin/sketchybar',
  'exec-and-forget ${pkgs.jankyborders}/bin/borders active_color=0xff89b4fa inactive_color=0xff45475a width=3.0',
]

# Start AeroSpace at login
start-at-login = true

# Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
enable-normalization-flatten-containers = true
enable-normalization-opposite-orientation-for-nested-containers = true

# See: https://nikitabobko.github.io/AeroSpace/guide#layouts
# The 'accordion-padding' specifies the size of accordion padding
# You can set 0 to disable the padding feature
accordion-padding = 30

# Possible values: tiles|accordion
default-root-container-layout = 'tiles'

# Possible values: horizontal|vertical|auto
# 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
#               tall monitor (anything higher than wide) gets vertical orientation
default-root-container-orientation = 'auto'

# Possible values: (qwerty|dvorak)
# See https://nikitabobko.github.io/AeroSpace/guide#key-mapping
key-mapping.preset = 'qwerty'

# Mouse follows focus when focused monitor changes
# Drop it from your config, if you don't like this behavior
# See https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
# See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

# Notify Sketchybar about workspace change
exec-on-workspace-change = [
    '/bin/bash',
    '-c',
    '${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change AEROSPACE_FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE AEROSPACE_PREV_WORKSPACE=$AEROSPACE_PREV_WORKSPACE',
]

# Gaps between windows (inner-*) and between monitor edges (outer-*).
# Possible values:
# - Constant:     gaps.outer.top = 8
# - Per monitor:  gaps.outer.top = [{ monitor.main = 16 }, { monitor."some-pattern" = 32 }, 24]
#                 In this example, 24 is a default value when there is no match.
#                 Monitor pattern is the same as for 'workspace-to-monitor-force-assignment'.
#                 See: https://nikitabobko.github.io/AeroSpace/guide#assign-workspaces-to-monitors
[gaps]
inner.horizontal = 15
inner.vertical =   15
outer.left =       13
outer.bottom =     13
outer.top =        [{ monitor."built-in" = 13 }, 47]
outer.right =      13

# 'main' binding mode declaration
# See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
# 'main' binding mode must be always presented
[mode.main.binding]

# All possible keys:
# - Letters.        a, b, c, ..., z
# - Numbers.        0, 1, 2, ..., 9
# - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
# - F-keys.         f1, f2, ..., f20
# - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon, backtick,
#                   leftSquareBracket, rightSquareBracket, space, enter, esc, backspace, tab
# - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
#                   keypadMinus, keypadMultiply, keypadPlus
# - Arrows.         left, down, up, right

# All possible modifiers: cmd, alt, ctrl, shift

# All possible commands: https://nikitabobko.github.io/AeroSpace/commands

# You can uncomment this line to open up terminal with alt + enter shortcut
# See: https://nikitabobko.github.io/AeroSpace/commands#exec-and-forget
# alt-enter = 'exec-and-forget open -n /System/Applications/Utilities/Terminal.app'

# See: https://nikitabobko.github.io/AeroSpace/commands#layout
alt-slash = 'layout tiles horizontal vertical'
alt-comma = 'layout accordion horizontal vertical'

cmd-shift-c = 'close'
cmd-enter = 'exec-and-forget open -n /Users/daniel/Applications/Home\ Manager\ Apps/WezTerm.app'

# See: https://nikitabobko.github.io/AeroSpace/commands#focus
cmd-h = ['focus left', 'move-mouse window-lazy-center']
cmd-j = ['focus down', 'move-mouse window-lazy-center']
cmd-k = ['focus up', 'move-mouse window-lazy-center']
cmd-l = ['focus right', 'move-mouse window-lazy-center']

# See: https://nikitabobko.github.io/AeroSpace/commands#move
cmd-shift-h = 'move left'
cmd-shift-j = 'move down'
cmd-shift-k = 'move up'
cmd-shift-l = 'move right'

# See: https://nikitabobko.github.io/AeroSpace/commands#resize
cmd-shift-minus = 'resize smart -50'
cmd-shift-equal = 'resize smart +50'

# See: https://nikitabobko.github.io/AeroSpace/commands#workspace
cmd-1 = 'workspace 1'
cmd-2 = 'workspace 2'
cmd-3 = 'workspace 3'
cmd-4 = 'workspace 4'
cmd-5 = 'workspace 5'
cmd-6 = 'workspace 6'
cmd-7 = 'workspace 7'
cmd-8 = 'workspace 8'
cmd-9 = 'workspace 9'
cmd-0 = 'workspace 10'

# See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
cmd-shift-1 = 'move-node-to-workspace 1'
cmd-shift-2 = 'move-node-to-workspace 2'
cmd-shift-3 = 'move-node-to-workspace 3'
cmd-shift-4 = 'move-node-to-workspace 4'
cmd-shift-5 = 'move-node-to-workspace 5'
cmd-shift-6 = 'move-node-to-workspace 6'
cmd-shift-7 = 'move-node-to-workspace 7'
cmd-shift-8 = 'move-node-to-workspace 8'
cmd-shift-9 = 'move-node-to-workspace 9'
cmd-shift-0 = 'move-node-to-workspace 10'

# See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
alt-tab = 'workspace-back-and-forth'
# See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

# tiling
cmd-shift-f = 'fullscreen'
cmd-shift-w = 'layout floating tiling'
cmd-shift-s = 'layout v_accordion' # 'layout stacking' in i3
cmd-shift-t = 'layout h_accordion' # 'layout tabbed' in i3
cmd-shift-e = 'layout tiles horizontal vertical' # 'layout toggle split' in i3
cmd-shift-d = 'resize width 1280'

# modes
# See: https://nikitabobko.github.io/AeroSpace/commands#mode
cmd-shift-semicolon = 'mode service'
cmd-shift-g = 'mode lock'

# 'service' binding mode declaration.
# See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
[mode.service.binding]
r = 'reload-config'
f = ['flatten-workspace-tree', 'mode main'] # reset layout
#s = ['layout sticky tiling', 'mode main'] # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
backspace = ['close-all-windows-but-current', 'mode main']

cmd-shift-h = ['join-with left', 'mode main']
cmd-shift-j = ['join-with down', 'mode main']
cmd-shift-k = ['join-with up', 'mode main']
cmd-shift-l = ['join-with right', 'mode main']

enter = 'mode main'
esc = 'mode main'

[mode.lock.binding]
enter = 'mode main'
esc = 'mode main'

[mode.resize.binding]
enter = 'mode main'
esc = 'mode main'

#
# Window rules
#

[[on-window-detected]]
if.app-id = 'com.github.wez.wezterm'
run = 'move-node-to-workspace 1'

[[on-window-detected]]
if.app-id = 'org.gnu.Emacs'
run = 'move-node-to-workspace 1'

[[on-window-detected]]
if.app-id = 'com.google.Chrome'
run = 'move-node-to-workspace 2'

[[on-window-detected]]
if.app-id = 'Safari'
run = 'move-node-to-workspace 2'

[[on-window-detected]]
if.app-id = 'Music'
run = 'move-node-to-workspace 8'

[[on-window-detected]]
if.app-id = 'com.microsoft.Outlook'
run = 'move-node-to-workspace 9'

[[on-window-detected]]
if.app-id = 'Mail'
run = 'move-node-to-workspace 9'

[[on-window-detected]]
if.app-id = 'com.microsoft.teams2'
run = 'move-node-to-workspace 10'

[[on-window-detected]]
if.app-id = 'Discord'
run = 'move-node-to-workspace 10'
  '';

  xdg.configFile."sketchybar/sketchybarrc".executable = true;
  xdg.configFile."sketchybar/sketchybarrc".source = ../configs/sketchybar/sketchybarrc;

  xdg.configFile."sketchybar/items".source = ../configs/sketchybar/items;
  xdg.configFile."sketchybar/plugins".source = ../configs/sketchybar/plugins;
  xdg.configFile."sketchybar/colors.sh".source = ../configs/sketchybar/colors.sh;
  xdg.configFile."sketchybar/colors.sh".executable = true;
}
