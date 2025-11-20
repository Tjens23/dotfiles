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

  users.users.toby = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      tree
    ];
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
  system.stateVersion = "25.05";

}

