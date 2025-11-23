
{  pkgs, ... }:
{  
  home.packages= with pkgs; [
    asdf
    stow
    neovim
    brave
    localsend
    ntfy-sh
    rustup
    go
    nodejs_24
    gcc
    libgcc
    zig
    unzip
    thefuck
    manix
    lazygit
    postman
    podman
    podman-desktop
  ];
}
