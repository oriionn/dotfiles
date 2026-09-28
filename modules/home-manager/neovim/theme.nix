{ pkgs, ... }:

{
    programs.nixvim = {
        extraPlugins = [ pkgs.vimPlugins.iceberg-vim ];
        colorscheme = "iceberg";
    };
}
