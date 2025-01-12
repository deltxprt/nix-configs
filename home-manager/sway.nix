{ ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      menu = "wofi --show run";
      bars = [{
        fonts.size = 12.0;
        position = "bottom";
      }];
      startup = [
        # Launch Firefox on start
        {command = "brave";}
      ];
    };
  };
}
