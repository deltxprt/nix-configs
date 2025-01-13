{ pkgs, ... }:
{  
  home.packages= with pkgs; [
    pkgs.stow
    pkgs.kitty
    pkgs.zsh
    pkgs.git
    pkgs.neovim
    pkgs.brave
    pkgs.jetbrains.idea-ultimate
    pkgs.localsend
    pkgs.ntfy-sh
    pkgs.polybar
    pkgs.wofi
    pkgs.rofi-wayland
    pkgs.waybar
    pkgs.rustup
    pkgs.go
    pkgs.nodejs_22
    pkgs.gcc
    pkgs.libgcc
    pkgs.zig
    pkgs.tmux
    pkgs.youtube-music
    pkgs.discord
    pkgs.unzip
    pkgs.thefuck
    pkgs.swaybg
    pkgs.manix
    pkgs.streamdeck-ui
  ];
}
