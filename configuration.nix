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
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/dotfiles/walls/wall1.png
    '';
    extraConfig = ''
      	Section "Monitor"
      	  Identifier "Virtual-1"
      	  Option "PreferredMode" "1920x1080"
      	EndSection
    '';
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  services.gns3-server.enable = true;
  services.blueman.enable = true;
  services.picom.enable = true;
  services.xserver.xkb.layout = "dk";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  programs.adb.enable = true;
  programs.fish.enable = true;
  users.users.toby = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "kvm" "libvirt" "wheel" "docker" "wireshark" "adbusers" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.postgresql = {
    enable = true;
  };

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    git
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

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/ff76aea3-64c4-423d-98ef-8905ccfadbd4";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

}

