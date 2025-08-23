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
    ./packages.nix
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
        mode = "3840x2160@120Hz";
        pos = "0 0";
        scale = "1";
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
    signing = {
      key = "";
      signByDefault = true;
    };
    extraConfig = {
      commit = {
        template = "~/.config/git/template";
        verbose = true;
      };

      code = {
        autocrlf = "input";
        compression = 9;
        fsync = "none";
        whitespace = "error";
        preloadindex = true;
      };

      advice = {
        addEmptyPathSpec = false;
        pushNonFastForward = false;
        statusHints = false;
      };

      blame = {
        coloring = "hihlightRecent";
        date = "relative";
      };

      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };

      init.defaultBranch = "dev";

      log = {
        abbrevCommit = true;
        graphColors = "blue,yellow,cyan,magenta,red";
      };

      status = {
        branch = true;
        short = true;
        showStash = true;
        showUntrackedFiles = "all";
      };
      
      pager = {
        branch = false;
        tag = false;
        diff = "delta";
        log = "delta";
        show = "delta";
        reflog = "delta";
      };

      push = {
        autoSetupRemote = true;
        default = "current";
        followTags = true;
        gpgSign = false;
      };

      pull = {
        rebase = true;
        default = "current";
      };
      
      submodule.fetchJobs = 16;

      rebase = {
        autoStash = true;
        missingCommitCheck = "warn";
      };

      pack = {
        threads = 0;
        windowMemory = "1g";
        packSizeLimit = "1g";
      };

      transfer.fsckObjects = true;
      receive.fsckObjects = true;
      fetch.fsckObjects = true;

      branch.sort = "-committerdate";
      tag.sort = "-taggerdate";

      color = {
        blame = { highlightRecent = "black bold,1 year ago, white, 1 month ago, default, 7 days ago, blue"; };
        branch = { current = "magenta"; local = "default"; remote = "yellow"; upstream = "green"; plain = "blue";};
        diff = { meta = "black bold"; frag = "magenta"; context = "white"; whitespace = "yellow reverse"; old = "red"; };
        deocrate = { HEAD = "red"; branch = "blue"; tag = "yellow"; remoteBranch = "magenta"; };
      };

      interactive = { 
        diffFilter = "delta --color-only";
        signleKey = true;
      };

      delta = {
        naviate = true;
        line-numbers = true;
        side-by-side = true;
        synthax-theme = "auto";
        features = "decorations";
      };
      
      delta.decorations = {
        commit-decorations-style = "bold yellow box";
        file-style = "bold yellow";
        hunk-header-style = "line-number synthax";
      };

      diff.coloMoved = "default";
      merge.configstyle = "zdiff3";

      
      url = {
        "git@github.com:" = { insteadOf = "gh:"; };
        "git@github.com:deltxprt/" = { insteadOf = "dx"; };
        "git@github.com:Markaplay-Game-Hosting/" = { insteadOf = "mgh"; };
      };
    };
  };
  
  # Enable home-manager 
  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
