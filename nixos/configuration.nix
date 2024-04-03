# System configuration:
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # Import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
    ./greed.nix
  ];

  nixpkgs = {
    # Add overlays:
    overlays = [
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
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

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Bootloader:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  programs.sway = {
    enable = true;
  };

  # XServer
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # i3 WM
  # services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.windowManager.i3 = {
  #   enable = true;
  #   package = pkgs.i3-gaps;
  #   extraPackages = with pkgs; [
  #     rofi # application launcher
  #     i3status # gives you the default i3 status bar
  #     i3lock #default i3 screen locker
  #     i3blocks #if you are planning on using i3blocks over i3status
  #   ];
  # };

  #services.desktopManager.cosmic.enable = true;
  #services.displayManager.cosmic-greeter.enable = true;
  

  # Keyboard Layouts:
  # services.xserver = {
  #   xkb.layout = "us, de";
  # };
  # 
  # environment.gnome.excludePackages = (with pkgs; [
  # gnome-photos
  # gnome-tour
  # gnome-console
  # xterm
  # gedit # text editor
  # ])
  # ++
  # (with pkgs.gnome; [
  # cheese # webcam tool
  # gnome-terminal
  # epiphany # web browser
  # geary # email reader
  # evince # document viewer
  # gnome-characters
  # totem # video player
  # tali # poker game
  # iagno # go game
  # hitori # sudoku game
  # atomix # puzzle game
  # gnome-maps
  # gnome-weather
  # yelp
  # ]);

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
  environment.systemPackages =
  (with pkgs; [
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
  # xdotool
  # maim
  # feh
  # (pkgs.buildFHSUserEnv {
  #   name = "neovim";
  #   runScript = "zsh";
  #   targetPkgs = pkgs: with pkgs; [
  #     neovim
  #     python311
  #     nodejs_21
  #     wl-clipboard
  #     ripgrep
  #   ];
  # })
  # gnomeExtensions.pop-shell
  ]);

  # Wayland related:
  security.polkit.enable = true;

  # Enable podman:
  virtualisation.podman = {
    enable = true;
  };

  # Enable Docker:
  virtualisation.docker = {
    enable = true;
  };

  # PostgreSQL
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_16;

  services.postgresql.ensureDatabases = [
    "books"
  ];

  # Printing & Scanning
  services.printing = {
    enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # SSH Server:
  services.openssh = {
    enable = true;
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
