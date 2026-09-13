{
    nixpkgs.config.allowUnfree = true;
    imports = [
        ./shell.nix
        ./terminal.nix
        ./multimedia.nix
        ./browser.nix
        ./audio.nix
        ./social.nix
        ./games.nix
        ./tools.nix
        ./utilities.nix
        ./info.nix
        ./hyprland.nix
        ./dev.nix
        ./style.nix
    ];
}
