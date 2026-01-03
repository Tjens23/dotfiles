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
    speedtest-cli
    asusctl
    unzip
    i3lock-color
    jetbrains-toolbox
    dysk
    jq
    gh
    flameshot
    lsof
    spotify
    net-tools
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

    # LSP Servers and Language Tools
    # Lua
    lua-language-server
    stylua

    # Python
    pyright
    python312Packages.black
    python312Packages.isort
    python312Packages.pylint
    ruff

    # JavaScript/TypeScript
    nodePackages.typescript-language-server
    nodePackages.eslint
    nodePackages.prettier
    vscode-langservers-extracted  # html, css, json, eslint

    # Go
    gopls
    gofumpt
    gotools
    golangci-lint

    # Rust
    rust-analyzer
    rustfmt
    clippy

    # C/C++
    clang-tools  # includes clangd, clang-format, clang-tidy
    cmake-language-server
    cpplint

    # Java
    jdt-language-server
    google-java-format

    # Additional formatters
    nodePackages.prettier
  ];

}

