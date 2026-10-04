{ ... }:

{
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.android_sdk.accept_license = true;

    home.sessionVariables = {
        ANDROID_HOME = "/run/current-system/sw/libexec/android-sdk";
        ANDROID_SDK_ROOT = "/run/current-system/sw/libexec/android-sdk";
    };
}
