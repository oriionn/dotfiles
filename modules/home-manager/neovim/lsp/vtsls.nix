{
    programs.nixvim.plugins.lsp.servers.vtsls = {
        enable = true;
        settings = {
            typescript.updateImportsOnFileMove.enabled = "always";
            javascript.updateImportsOnFileMove.enabled = "always";
        };
    };
}
