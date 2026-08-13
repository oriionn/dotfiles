{ config, pkgs, unstable, hyprquickshot, phoenix, downtime, ... }:

let
    username = "orion";
in
{
    imports =
     [
         ./desktop/kde.nix
         ./desktop/hyprland.nix
         ../config/userdirs.nix
     ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "framework"; # Define your hostname.

    # Enable NixOS experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable networking
    networking.networkmanager.enable = true;

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
        prismlauncher
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

        # System info
        waybar
        phoenix # https://git.oriondev.fr/orion/phoenix
        downtime # https://git.oriondev.fr/orion/downtime
        bottom

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
                appId = "com.hytale.Launcher";
                bundle = "file:///home/${username}/.dotfiles/flatpaks/hytale/app.flatpak";
                sha256 = lib.fileContents ../flatpaks/hytale/sha256.txt;
            }
        ];
    };


    # Games
    programs.steam = {
        enable = true;
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

    # Users
    users.users."${username}" = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };
    home-manager.users."${username}"" = import ./home.nix;

    # NixOS version
    system.stateVersion = "26.05";
}
