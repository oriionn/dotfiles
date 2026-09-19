{ pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        ghostty
        git
        neovim
        fastfetch
        inputs.ofetch.packages.${stdenv.hostPlatform.system}.default
    ];
}
