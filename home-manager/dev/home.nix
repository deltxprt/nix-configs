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
    ../packages.nix
    ../waybar.nix
    ../zsh.nix
    ../kitty.nix
    ../sway.nix
    ../tmux.nix
    ../pam-u2f.nix
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
      update = "cd ~/nix-configs && sudo nixos-rebuild switch --flake .#dev";
      uupdate = "cd ~/nix-configs && home-manager switch --flake .#delta@dev";
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


  wayland.windowManager.sway.config = {
    output = {
      HEADLESS-1 = {
        mode = "3840x2160@60Hz";
        pos = "0 0";
        scale = 1;
      };
    };
    startup = [
      {command = "swaybg -m fill -i ~/.config/backgrounds/landscape02.jpg"; always=true;}
    ];
  };

  programs.git = {
    enable = true;
    userName = "deltxprt";
    userEmail = "vincent.genest@protonmail.com";
  };

  # Enable home-manager 
  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
