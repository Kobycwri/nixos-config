{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    # You can explicitly set the package if needed
    package = pkgs.mako;

    settings = {
      # Behavior & timing
      default-timeout = 5000; # milliseconds
      max-visible = 5;
      sort = "-time";
      group-by = "app-name";
      actions = true;
      markup = true;

      # Placement & geometry
      anchor = "top-right";
      layer = "overlay";
      width = 350;
      height = 150;
      margin = "10";
      padding = "8";
      border-size = 2;
      border-radius = 12;
    };
  };
}
