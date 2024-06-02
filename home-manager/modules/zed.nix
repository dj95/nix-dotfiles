{
  config,
  pkgs,
  libs,
  ...
}:
{
  xdg.configFile."zed/settings.json".text = ''
    {
      "theme": "Catppuccin Mocha",
      "vim_mode": true,
      "ui_font_size": 16,

      "buffer_font_family": "Liga SFMono Nerd Font",
      "buffer_font_size": 16,

      "remove_trailing_whitespace_on_save": false,
      "show_whitespaces": "selection",

      "projects_online_by_default": false,
      "telemetry": {
        "diagnostics": false,
        "metrics": false
      },

      "terminal": {
        "font_family": "Liga SFMono Nerd Font",
        "font_size": 16,
        "shell": {
          "with_arguments": {
            "program": "${pkgs.fish}/bin/fish",
            "args": ["-l"]
          }
        }
      }
    }'';
}
