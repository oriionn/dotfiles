{
    programs.nixvim.plugins.lsp = {
        enable = true;
    };

    imports = [
        ./astro.nix
        ./c.nix
        ./csharp.nix
        ./go.nix
        ./lua.nix
        ./nix.nix
        ./php.nix
        ./python.nix
        ./vtsls.nix
    ];
}
