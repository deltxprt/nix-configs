{ config, pkgs, ... }:
{
  nix.settings = {
    substituters = config.nix.settings.substituters ++ [
    "https://hyprland.cachix.org"
    ];
    trusted-substituters = config.nix.settings.trusted-substituters ++ [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = config.nix.settings.trusted-public-keys ++ [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
