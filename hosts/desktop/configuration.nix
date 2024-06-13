# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, outputs, system, myLib, ... }:

{
  imports =
    [./hardware-configuration.nix];

  environment = {
    sessionVariables = {
      # FLAKE = "/home/jh/nixos-config";
    };
    systemPackages = with pkgs; [
      nh
      magic-wormhole
    ];
  };

  myNixOS = {
    bundles.users.enable = true;
    sharedSettings.hyprland.enable = true;
    home-users = {
      "jh" = {
        userConfig = ./home.nix;
	userSettings = {
	  extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
	};
      };
    };
    userConfig = ./home.nix;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jh = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
    ];
  };

  #programs.hyprland.enable = true;
  programs.zsh.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];

  networking.hostName = "nucleus"; # Define your hostname.
  networking.networkmanager.enable = true;
  
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
#  services.xserver = {
#    xkb = { 
#      variant = ""; 
#      layout = "us";
#    };
#  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true; #must have unfree

# Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia" "modesetting" ];

  powerManagement.cpuFreqGovernor = "performance";

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  system.stateVersion = "23.11"; # Did you read the comment?
}
