{ pkgs, ... }:

{
  hardware.uinput.enable = true;

  # Install the uaccess rule with a priority lower than 73
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "70-mouse-uaccess.rules";
      destination = "/etc/udev/rules.d/70-mouse-uaccess.rules";
      text = ''
        # Grant uaccess to your specific mouse (Vendor 18f8, Product 1286)
        SUBSYSTEM=="input", KERNEL=="event*", ATTRS{idVendor}=="18f8", ATTRS{idProduct}=="1286", TAG+="uaccess"

        # Grant uaccess to uinput for generating synthetic clicks
        SUBSYSTEM=="misc", KERNEL=="uinput", TAG+="uaccess"
      '';
    })
  ];
}
