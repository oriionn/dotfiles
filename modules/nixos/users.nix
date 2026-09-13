{ username, pkgs, ... }:

{
    users.users."${username}" = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "libvirtd" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };
}
