{
    programs.nixvim.keymaps = [
        # Better window navigation
        {
            mode = "n";
            key = "<C-S-Left>";
            action = "<C-w>h";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-S-Down>";
            action = "<C-w>j";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-S-Up>";
            action = "<C-w>k";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-S-Right>";
            action = "<C-w>l";
            options.noremap = true;
            options.silent = true;
        }

        # Resize with arrows
        {
            mode = "n";
            key = "<C-Up>";
            action = ":resize -2<CR>";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-Down>";
            action = ":resize +2<CR>";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-Left>";
            action = ":vertical resize -2<CR>";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "n";
            key = "<C-Right>";
            action = ":vertical resize +2<CR>";
            options.noremap = true;
            options.silent = true;
        }

        # Visual mode
        {
            mode = "v";
            key = "<";
            action = "<gv";
            options.noremap = true;
            options.silent = true;
        }
        {
            mode = "v";
            key = ">";
            action = ">gv";
            options.noremap = true;
            options.silent = true;
        }
    ];
}
