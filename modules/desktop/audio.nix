{ ... }:
{
  services.pulseaudio.enable = false;
  security.rttkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig."51-cmedia-soft-mixer" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "device.name" = "~alsa_card.usb-0d8c_C-Media.*"; }
          { "device.vendor.id" = "usb:0d8c"; }
          { "device.product.id" = "0x000c"; }
        ];
        actions = {
          update-props = {
            "api.alsa.soft-mixer" = true;
          };
        };
      }
    ];
  };
}
