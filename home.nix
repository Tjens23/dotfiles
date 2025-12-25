{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    rofi = "rofi";
    alacritty = "alacritty";
    picom = "picom";
  };
in

{
  nixpkgs.config.allowUnfree = true;
  home.username = "toby";
  home.homeDirectory = "/home/toby";
  programs.git = {
    enable = true;
    userName = "tjens23";
    userEmail = "tjens23@student.sdu.dk";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  home.stateVersion = "25.11";

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos-btw";
      nrs = "nh os switch";
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    xclip
    obs-studio
    kubectl
    xournalpp
    alvr
    tshark
    xf86_input_wacom
    twingate
    lua51Packages.lgi
    tmux
    google-cloud-sdk
    go
    cargo
    adoptopenjdk-icedtea-web
    woeusb
    forgejo-runner
    speedtest-cli
    asusctl
    unzip
    i3lock-color
    jetbrains-toolbox
    dysk
    jq
    ollama
    gns3-gui
    kdePackages.dolphin
    gns3-server
    usbutils
    kdePackages.okular
    miktex
    vscode
    wine64
    neovim
    jdk21
    maven
    pnpm
    android-studio
    dig
    iperf
    gemini-cli
    postgresql
    fastfetch
    vlc
    htop
    vesktop
    fd
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    fzf
    yazi
    gcc
    rofi
    xwallpaper
  ];

}

