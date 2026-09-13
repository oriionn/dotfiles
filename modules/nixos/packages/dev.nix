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

        # LSP
        nixd
        nil
        lua-language-server
        rust-analyzer
        roslyn-ls
        csharp-ls
        ruff
        vtsls
    ];
}
