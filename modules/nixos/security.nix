{
    # Keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.ly.enableGnomeKeyring = true;

    # Polkit
    security.polkit.enable = true;
}
