{ ... }:

{
  imports = [
    # ./example.nix - add your modules here
    ./davinci-resolve.nix
  ];

  environment.systemPackages = [
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];

  hydenix.gaming.enable = false;
}
