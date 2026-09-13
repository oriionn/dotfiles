{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        zoxide
        eza
        fzf
    ];
}
