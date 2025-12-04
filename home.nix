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
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos-btw";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#sdu";
    };
    initExtra = ''
      	  export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      	'';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  services.easyeffects.enable = true;
  home.packages = with pkgs; [
    terraform
    postgresql_17_jit
    easyeffects
    obs-studio
    kubectl
    xournalpp
    alvr
    xf86_input_wacom
    twingate
    tmux
    google-cloud-sdk
    speedcrunch
    go
    prismlauncher
    tshark
    twingate
    act
    sageWithDoc
    vlc
    vscode
    steam
    sidequest
    flameshot
    kdePackages.okular
    protonplus
    unzip
    i3lock-color
    kdePackages.dolphin
    jetbrains-toolbox
    dysk
    jq
    spotify
    neovim
    pay-respects
    fastfetch
    google-cloud-sdk
    jdk25_headless
    gemini-cli
    vesktop
    ripgrep
    nil
    usbutils
    nixpkgs-fmt
    nodejs
    fzf
    yazi
    gcc
    rofi
    xwallpaper
  ];

}

