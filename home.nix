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
      
      # Better diffs
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      
      # Rebase by default on pull
      pull.rebase = true;
      
      # Auto-correct typos
      help.autocorrect = "immediate";
      
      # Better merge conflict style
      merge.conflictstyle = "zdiff3";
      
      # Prune on fetch
      fetch.prune = true;
      fetch.prunetags = true;
      
      # Rerere (reuse recorded resolution)
      rerere.enabled = true;
      
      # Better log output
      log.date = "relative";
      
      # Push current branch by default
      push.default = "current";
      push.autoSetupRemote = true;
      
      # Colored output
      color.ui = "auto";
      
      # Better status
      status.showUntrackedFiles = "all";
      status.submoduleSummary = true;
      
      # Commit signing (optional - uncomment if you use GPG)
      # commit.gpgsign = true;
      # tag.gpgsign = true;
    };
    
    aliases = {
      # Short status
      s = "status -sb";
      
      # Better log
      l = "log --oneline --graph --decorate";
      ll = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      
      # Amend last commit
      amend = "commit --amend --no-edit";
      
      # Quick commit
      c = "commit -m";
      ca = "commit -am";
      
      # Better diff
      d = "diff";
      ds = "diff --staged";
      
      # Branches
      b = "branch";
      ba = "branch -a";
      bd = "branch -d";
      
      # Checkout
      co = "checkout";
      cob = "checkout -b";
      
      # Stash with message
      ss = "stash save";
      sl = "stash list";
      sp = "stash pop";
      
      # Undo last commit (keep changes)
      undo = "reset HEAD~1 --soft";
      
      # Force push with lease (safer)
      pushf = "push --force-with-lease";
      
      # Clean up merged branches
      cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master\\|develop' | xargs -n 1 git branch -d";
      
      # Show what changed in last commit
      last = "log -1 HEAD --stat";
      
      # Interactive rebase
      rb = "rebase -i";
      
      # Quick pull and push
      pl = "pull";
      ps = "push";
    };
    
    ignores = [
      # OS files
      ".DS_Store"
      "Thumbs.db"
      
      # Editor files
      ".vscode/"
      ".idea/"
      "*.swp"
      "*.swo"
      "*~"
      ".nvimlog"
      
      # Build artifacts
      "node_modules/"
      "dist/"
      "build/"
      "target/"
      "*.log"
      
      # Environment files
      ".env"
      ".env.local"
    ];
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
    gnumake

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

