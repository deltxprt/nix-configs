# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./packages.nix
    ./waybar.nix
    ./zsh.nix
    ./kitty.nix
    ./sway.nix
    ./tmux.nix
    ./pam-u2f.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.zsh.shellAliases = {
      update = "cd ~/Documents/nix-configs && sudo nixos-rebuild switch --flake .#desktop";
      uupdate = "cd ~/Documents/nix-configs && home-manager switch --flake .#delta@desktop";
  };

  home = {
    username = "delta";
    homeDirectory = "/home/delta";
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 20;
    };
  };


  home.packages = with pkgs; [
    youtube-music
    discord
    streamdeck-ui
  ];

  wayland.windowManager.sway.config.output = {
    DP-1 = {
      pos = "0 0";
      adaptive_sync = "on";
    };
    DP-2 = {
      pos = "2560 750";
    };
  };

  wayland.windowManager.sway.config.startup = [
    {command = "swaybg -m fill -i ~/.config/backgrounds/landscape02.jpg"; always=true;}
  ];

  programs.git = {
    enable = true;
    userName = "deltxprt";
    userEmail = "vincent.genest@protonmail.com";
  };

  # Enable home-manager 
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";



  services.gnome-keyring.enable = true;


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
