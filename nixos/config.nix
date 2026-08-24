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

    # Plymouth
    boot.plymouth = {
        enable = true;
        theme = "blahaj";
        themePackages = with pkgs; [
            (plymouth-blahaj-theme.overrideAttrs (old: {
                postInstall = (old.postInstall or "") + ''
                    install -Dm644 ${../assets/boot.png} \
                        $out/share/plymouth/themes/blahaj/watermark.png

                    substituteInPlace \
                        $out/share/plymouth/themes/blahaj/blahaj.plymouth \
                        --replace-fail \
                            "WatermarkVerticalAlignment=.96" \
                            "WatermarkVerticalAlignment=.88"

                    ${imagemagick}/bin/magick mogrify \
                        -resize 150% \
                        $out/share/plymouth/themes/blahaj/animation-*.png \
                        $out/share/plymouth/themes/blahaj/throbber-*.png
                '';
            }))
        ];
    };

    boot.consoleLogLevel = 3;
    boot.initrd.verbose = false;
    boot.kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
    ];

    networking.hostName = "framework"; # Define your hostname.

    # Enable NixOS experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable networking
    networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";

        plugins = with pkgs; [
            networkmanager-openconnect
            networkmanager-fortisslvpn
        ];
    };

    services.resolved = {
        enable = true;

        settings.Resolve = {
            DNS = [
                "194.242.2.2 #dns.mullvad.net"
                "1.1.1.1 #cloudflare-dns.com"
                "1.0.0.1 #cloudflare-dns.com"
            ];

            FallbackDNS = "";
            Domains = "~.";
            DNSSEC = "allow-downgrade";
            DNSOverTLS = "yes";
        };
    };

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

    # Udev rules
    services.udev.extraRules = ''
    # This rule was added by Solaar.
    #
    # Allows non-root users to have raw access to Logitech devices.
    # Allowing users to write to the device is potentially dangerous
    # because they could perform firmware updates.

    ACTION == "remove", GOTO="solaar_end"
    SUBSYSTEM != "hidraw", GOTO="solaar_end"

    # USB-connected Logitech receivers and devices
    ATTRS{idVendor}=="046d", GOTO="solaar_apply"

    # Lenovo nano receiver
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"

    # Bluetooth-connected Logitech devices
    KERNELS == "0005:046D:*", GOTO="solaar_apply"

    GOTO="solaar_end"

    LABEL="solaar_apply"

    # Allow any seated user to access the receiver.
    # uaccess: modern ACL-enabled udev
    TAG+="uaccess"

    # Grant members of the "plugdev" group access to receiver (useful for SSH users)
    #MODE="0660", GROUP="plugdev"

    LABEL="solaar_end"
    # vim: ft=udevrules
        '';

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
        remmina
        cura-appimage

        # Utilities
        udiskie
        swaynotificationcenter
        nwg-bar
        kdePackages.dolphin
        brightnessctl
        xdg-utils
        networkmanagerapplet
        glib
        unzip
        solaar
        dnsmasq # Libvirtd network
        ffmpeg-full
        imagemagick

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
        unstable.rustc
        unstable.cargo
        gnumake
        gcc

        # LSP
        nixd
        nil
        lua-language-server
        rust-analyzer

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
            numlock = true;
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

    # Local Send
    programs.localsend = {
        enable = true;
        openFirewall = true;
    };

    # Fingerprint scanner
    # services.fprintd.enable = true;
    # security.pam.services.login.rules.auth.fprintd.settings = {
    #     timeout = 5;
    # };
    # security.pam.services.hyprlock = {
    #     fprintAuth = false;
    # };

    # Docker
    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    # Virutal Machines
    virtualisation.libvirtd = {
        enable = true;
        onBoot = "start";
        onShutdown = "shutdown";
    };
    programs.virt-manager.enable = true;

    # Users
    users.users."${username}" = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "libvirtd" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };
    home-manager.users."${username}" = import ./home.nix;

    # NixOS version
    system.stateVersion = "26.05";
}
