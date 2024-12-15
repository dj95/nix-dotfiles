{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.rio = {
    enable = true;
    settings = {
      colors = {
        background = "#000000";
        foreground = "#e0def4";
        selection-background = "#403d52";
        selection-foreground = "#e0def4";

        cursor = "#e0def4";

        tabs = "#191724";
        tabs-active = "#26233a";

        black = "#26233a";
        red = "#eb6f92";
        green = "#31748f";
        yellow = "#f6c177";
        blue = "#9ccfd8";
        magenta = "#c4a7e7";
        cyan = "#ebbcba";
        white = "#e0def4";

        dim-black = "#6e6a86";
        dim-red = "#eb6f92";
        dim-green = "#31748f";
        dim-yellow = "#f6c177";
        dim-blue = "#9ccfd8";
        dim-magenta = "#c4a7e7";
        dim-cyan = "#ebbcba";
        dim-white = "#e0def4";

        light-black = "#6e6a86";
        light-red = "#eb6f92";
        light-green = "#31748f";
        light-yellow = "#f6c177";
        light-blue = "#9ccfd8";
        light-magenta = "#c4a7e7";
        light-cyan = "#ebbcba";
        light-white = "#e0def4";
      };
      cursor = {
        shape = "beam";
      };
      fonts = {
        size = 15;
        family = "Liga SFMono Nerd Font";
        features = ["+ss01"  "+ss02"  "+ss04"  "+ss05"];
        # extras = [{ family = "Apple Color Emoji"}];
      };
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = ["--login"];
      };
      window = {
        blur = true;
        opacity = 0.85;
      };
    };
  };
}
