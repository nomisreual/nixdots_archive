{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # Import modules:
  imports = [
    ./hardware-configuration.nix
    ./greed.nix
  ];

  # Configure nixpkgs:
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Add each flake input as a registry;
  # to make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  environment.sessionVariables = {
    FLAKE = "/home/simon/Configurations/System";
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Bootloader:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Plymouth splash screen:
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "i1915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Networking:
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  # Sound:
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Locales:

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/simon/Configurations/System";
  };

  # Enable ZSH:
  programs.zsh.enable = true;

  # Enable vim and set it to be the default editor:
  programs.vim.defaultEditor = true;

  # System-wide user settings:
  users.users = {
    simon = {
      isNormalUser = true;
      description = "Simon Antonius Lauer";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "scanner"
        "lp"
      ];
    };
  };

  # System-wide packages:
  environment.systemPackages = with pkgs; [
    gcc
    stow
    gnumake
    unzip
    curl
    kitty
    vim
    wget
    tree
    git
    neofetch
    zoxide

    nix-output-monitor
    nvd
  ];

  # Wayland related:
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
  security.polkit.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Gnome Virtual Filesystem
  # basically enables Trash in Gnome Nautilus
  services.gvfs.enable = true;

  # Styling
  stylix = {
    image = /home/simon/Wallpapers/Anime_Girl.jpg;
    polarity = "dark";
  };

  # Flatpak
  services.flatpak.enable = true;

  # Enable Podman:
  virtualisation.podman = {
    enable = true;
  };

  # Enable Docker:
  virtualisation.docker = {
    enable = true;
  };

  # Printing & Scanning
  services.printing = {
    enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # MongoDB
  services.mongodb = {
    enable = true;
  };

  # PostgreSQL
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_16;

  services.postgresql.ensureDatabases = [
    "books"
  ];

  # SSH Server:
  services.openssh = {
    enable = false;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only.
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
