{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "sdu";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  services.displayManager.ly.enable = true;

  time.timeZone = "Europe/Copenhagen";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;

    # Use NVIDIA proprietary drivers
    videoDrivers = [ "nvidia" ];

    displayManager.sessionCommands = ''
      xrandr --output HDMI-1 --mode 1920x1080 --rate 144 --primary
      xwallpaper --zoom ~/dotfiles/walls/wall1.png
    '';
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

  };

  networking.firewall.allowedUDPPorts = [
    9943
    9944
  ];


  networking.firewall.allowedTCPPorts = [
    9943
    9944
  ];
  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  

  # NVIDIA configuration
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  # Updated: hardware.opengl is now hardware.graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit apps/games
  };


  programs.dconf.enable = true;
  services.picom.enable = true;
  services.xserver.xkb.layout = "dk";

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
  };

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };


  security.rtkit.enable = true; # Real-time scheduling for low latency
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = false;

    # Add audio configuration here
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 128;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 512;
      };
    };
  };

  programs.wireshark.enable = true;

  users.users.toby = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "wireshark" "input" "plugdev" ];
    packages = with pkgs; [
      tree
    ];
  };



  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    arandr
    wget
    curl
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  virtualisation.docker.enable = true;

  services.twingate.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/toby/dotfiles/";
  };

  # ... your existing config ...

  fileSystems."/mnt/development" = {
    device = "/dev/disk/by-uuid/8a3c73d1-8cf6-4c19-9653-4677fe81d56e";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/5419c59c-ff56-4c37-a1e7-196c21593cdb";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

}

