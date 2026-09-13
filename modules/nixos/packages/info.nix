{ pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
	waybar
#        inputs.waybar.packages.${stdenv.hostPlatform.system}.default
        inputs.phoenix.packages.${stdenv.hostPlatform.system}.default # https://git.oriondev.fr/orion/phoenix
        inputs.downtime.packages.${stdenv.hostPlatform.system}.default # https://git.oriondev.fr/orion/downtime
        bottom
        mission-center
    ];
}
