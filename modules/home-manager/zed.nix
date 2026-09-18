{
    programs.zed-editor = {
        enable = true;

        userSettings = {
            lsp = {
                vtsls = {
                    settings = {
                        typescript.updateImportsOnFileMove.enabled = "always";
                        javascript.updateImportsOnFileMove.enabled = "always";
                    };
                    enable_lsp_tasks = true;
                    binary = {
                        arguments = ["--stdio"];
                        path = "vtsls";
                    };
                };

                lua-language-server.binary.path = "lua-language-server";
                roslyn.binary = {
                    path = "Microsoft.CodeAnalysis.LanguageServer";
                    arguments = ["--stdio"];
                };

                ruff.binary.path = "ruff";
                package-version-server.binary.path = "package-version-server";
                phpactor.binary.path = "phpactor";
                gopls.binary.path = "gopls";
                clangd.binary.path = "clangd";
            };

            cli_default_open_behavior = "new_window";
            project_panel.dock = "left";
            outline_panel.dock = "left";

            theme = {
                mode = "dark";
                light = "One Light";
                dark = "One Dark Pro";
            };

            autosave = "off";
            agent = {
                dock = "right";
                default_profile = "ask";
                default_model = {
                    effort = "medium";
                    provider = "zed.dev";
                    model = "claude-sonnet-4.6";
                };
            };

            restore_on_startup = "last_session";
            base_keymap = "VSCode";

            edit_predictions.disabled_globs = ["**"];
            show_edit_predictions = false;

            buffer_font_family = "JetBrainsMono Nerd Font Mono";
            buffer_font_size = 14;
            ui_font_family = "JetBrainsMono Nerd Font Mono";
            ui_font_size = 15;

            collaboration_panel = {
                dock = "left";
                button = false;
            };
            git_panel.dock = "left";

            terminal = {
                dock = "right";
                scrollbar.show = "never";
                cursor_shape = "bar";
                font_family = "JetBrainsMono Nerd Font Mono";
            };

            tab_size = 4;
            scroll_bar.show = "never";

            languages = {
                Java.show_edit_predictions = true;
                Python = {
                    language_servers = ["ruff"];
                    format_on_save = "on";
                    formatter = [
                        { code_action = "source.fixAll.ruff"; }
                        { code_action = "source.organizeImports.ruff"; }
                        { language_server = { name = "ruff"; }; }
                    ];
                };
            };

            title_bar = {
                show_branch_status_icon = true;
                show_user_picture = true;
                show_onboarding_banner = false;
            };

            telemetry = {
                metrics = false;
                diagnostics = false;
            };

            calls.mute_on_join = true;
            tab_bar = {
                show_nav_history_buttons = false;
                show_tab_bar_buttons = false;
            };

            format_on_save = "off";
            use_on_type_format = false;
        };
    };
}
