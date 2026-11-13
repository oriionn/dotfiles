{ pkgs, ... }:

let
    androidComposition = pkgs.androidenv.composeAndroidPackages {
        numLatestPlatformVersions = 5;
        buildToolsVersions = [ "36.0.0" "latest" ];

        includeEmulator = "if-supported";
        includeSystemImages = "if-supported";

        includeCmake = true;
        cmakeVersions = [ "3.22.1" "latest" ];

        includeNDK = true;
        ndkVersions = [ "28.2.13676358" ];
    };

    monoCompat = pkgs.linkFarm "mono-compat" {
        "mono-compat.targets" = pkgs.writeText "mono-compat.targets" ''
            <Project>
                <PropertyGroup>
                    <TargetFramework>net472</TargetFramework>
                    <LangVersion>7.0</LangVersion>
                    <ImplicitUsings>disable</ImplicitUsings>
                    <Nullable>disable</Nullable>
                    <FrameworkPathOverride>${pkgs.mono}/lib/mono/4.7.2-api/</FrameworkPathOverride>
                </PropertyGroup>
            </Project>
        '';

        ".editorconfig" = pkgs.writeText "editorconfig" ''
            root = true

            [*.cs]
            dotnet_diagnostic.CS8933.severity = none
            dotnet_diagnostic.IDE0005.severity = none
        '';
    };
in
{
    environment.systemPackages = with pkgs; [
        zed-editor
        bun
        nodejs
        go
        rustc
        cargo
        gnumake
        gcc
        python3
        dotnet-sdk_10
        mono
        php
        phpPackages.composer
        dart
        flutter
        androidComposition.androidsdk
        (android-studio.withSdk androidComposition.androidsdk)
        mars-mips

        # LSP
        nixd
        nil
        lua-language-server
        rust-analyzer
        roslyn-ls
        csharp-ls
        ruff
        vtsls
        package-version-server
        phpactor
        clang
        gopls
        astro-language-server
        tinymist

        # Libs
        ddcutil
        pkg-config
    ];

    environment.variables.PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig:/run/current-system/sw/share/pkgconfig";
    environment.sessionVariables.CustomBeforeMicrosoftCommonProps = "${monoCompat}/mono-compat.targets";

    systemd.services.editorconfig-partage-mount = {
        wantedBy = [ "multi-user.target" ];
        unitConfig.RequiresMountsFor = "/mnt/Partage";
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
        };
        script = ''
            cp --no-preserve=all ${monoCompat}/.editorconfig /mnt/Partage/.editorconfig
        '';
    };

    nixpkgs.config.android_sdk.accept_license = true;
    programs.java.enable = true;
}
