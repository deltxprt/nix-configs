
{  pkgs, ... }:
{
  home.packages= with pkgs; [
    asdf
    stow
    neovim
    brave
    librewolf
    localsend
    ntfy-sh
    rustup
    go
    nodejs_24
    gcc
    libgcc
    zig
    unzip
    pay-respects
    manix
    lazygit
    postman
    podman
    podman-desktop
  ];
}
