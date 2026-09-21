{ pkgs, ... }:

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
        androidsdk
        android-studio-full

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
    ];

    nixpkgs.config.android_sdk.accept_license = true;
}
