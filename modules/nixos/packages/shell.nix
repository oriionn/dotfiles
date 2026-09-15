{ pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        zoxide
        eza
        fzf
        inputs.pyroclear.packages.${stdenv.hostPlatform.system}.default
    ];
}
