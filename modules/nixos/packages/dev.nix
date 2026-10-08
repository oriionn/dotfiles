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
    ];

    nixpkgs.config.android_sdk.accept_license = true;
    programs.java.enable = true;
}
