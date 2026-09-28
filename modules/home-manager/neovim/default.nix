{
    programs.nixvim.enable = true;
    imports = [
        ./lsp

        ./options.nix
        ./keybindings.nix
        ./theme.nix
    ];
}
