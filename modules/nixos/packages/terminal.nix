{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        ghostty
        git
        neovim
        fastfetch
    ];
}
