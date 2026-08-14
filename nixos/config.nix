{ config, lib, pkgs, unstable, hyprquickshot, phoenix, downtime, username, waybar-flake, ... }:

let
    home = config.users.users.${username}.home;
in
{
    imports =
     [
         ./desktop/kde.nix
         ./desktop/hyprland.nix
         ../config/userdirs.nix
         ./cleanup.nix
     ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 5;

    networking.hostName = "framework"; # Define your hostname.

    # Enable NixOS experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "none";
    networking.nameservers = [
        "194.242.2.2" # Mullvad
        "1.1.1.1" # Cloudflare
        "1.0.0.1" # Secondary Cloudflare
    ];

    # Keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.ly.enableGnomeKeyring = true;

    # Polkit
    security.polkit.enable = true;

    # Bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Experimental = true;
            };
        };
    };

    # Region settings
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
    };

    # Keyboard
    services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
    };
    console.keyMap = "fr";

    # Printer
    services.printing = {
        enable = true;
        drivers = [ pkgs.cnijfilter2 ];
    };
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    # Packages
    environment.systemPackages = with pkgs; [
        # Terminal
        ghostty
        git
        neovim
        fastfetch

        # Multimedia
        vlc
        delfin
        feishin

        # Browser
        firefox
        ungoogled-chromium

        # Audio
        playerctl
        pavucontrol

        # Social Media
        vesktop

        # Games
        (prismlauncher.override {
            additionalPrograms = [ ffmpeg ];

            jdks = [
                zulu8
                zulu17
                zulu21
                zulu
            ];
        })
        steam

        # Tools
        penpot-desktop
        obsidian
        freecad

        # Utilities
        udiskie
        swaynotificationcenter
        nwg-bar
        kdePackages.dolphin
        brightnessctl
        xdg-utils
        glib
        networkmanagerapplet

        # System info
        waybar-flake
        phoenix # https://git.oriondev.fr/orion/phoenix
        downtime # https://git.oriondev.fr/orion/downtime
        bottom
        mission-center

        # Shell
        zoxide
        eza
        fzf

        # Hyprland
        unstable.hyprpolkitagent
        hyprquickshot # https://github.com/JamDon2/hyprquickshot
        hyprpicker

        # Development
        zed-editor
        bun
        nodejs
        go
        gnumake
        gcc

        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only

         # Theming
         kdePackages.breeze
         kdePackages.plasma-integration
    ];
    programs.zsh.enable = true;


    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "com.hypixel.HytaleLauncher";
                bundle = "file://${home}/.dotfiles/flatpaks/hytale/app.flatpak";
                sha256 = lib.fileContents ../flatpaks/hytale/sha256.txt;
            }
        ];
        uninstallUnmanaged = true;
    };

    # Games
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    # Ly
    services.displayManager.ly = {
        enable = true;
        x11Support = false;

        settings = {
            xsessions = null;
            shell = false;
        };
    };

    # Git configuration
    programs.git = {
        enable = true;
        config = {
            user = {
                name = "Orion";
                email = "contact@oriondev.fr";
            };
        };
    };

    # Fingerprint scanner
    services.fprintd.enable = true;
    security.pam.services.login.rules.auth.fprintd.settings = {
        timeout = 5;
    };
    security.pam.services.hyprlock = {
        fprintAuth = false;
    };

    # Docker
    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    # Users
    users.users."${username}" = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };
    home-manager.users."${username}" = import ./home.nix;

    # NixOS version
    system.stateVersion = "26.05";
}
