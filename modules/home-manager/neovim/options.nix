{
    programs.nixvim = {
        opts = {
            clipboard = "unnamedplus";
            completeopt = ["menu" "menuone" "noselect"];
            mouse = "a";

            # Tab
            tabstop = 4;
            softtabstop = 4;
            shiftwidth = 4;
            expandtab = true;

            # UI Config
            number = true;
            relativenumber = false;
            cursorline = true;
            splitbelow = true;
            splitright = true;
            termguicolors = true;
            showmode = false;

            # Searching
            incsearch = true;
            hlsearch = false;
            ignorecase = true;
            smartcase = true;
        };

        diagnostic.settings = {
            virtual_text = true;
            signs = true;
            underline = true;
            update_in_insert = true;
            severity_sort = true;
        };
    };
}
