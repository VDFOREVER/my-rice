{ config, pkgs, ... }:

{
    imports =
    [
      ../../modules/system.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    # Bootloader.
    # Use the GRUB 2 boot loader.
    boot.loader = {
        grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            useOSProber = true;
        };
        efi.efiSysMountPoint = "/boot/efi";
    };

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    programs.gnupg.agent.enable = true;

    system.stateVersion = "24.05";
}