{ pkgs, ... }:

{
    # Theming
    environment.systemPackages = with pkgs; [
         kdePackages.breeze
         kdePackages.plasma-integration
    ];

    # Fonts
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];
}
