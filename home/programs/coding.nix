{ pkgs, lib, ... }: # <-- added `lib` for lib.getExe
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "luau" ];

    # Injected directly into Zed's PATH (replaces the need for nix-ld!)
    extraPackages = with pkgs; [
      # Needed by Zed itself (settings.json / built-in tooling)
      nodejs
      vscode-langservers-extracted

      # Go
      go
      gopls
      delve

      # Python
      basedpyright
      ruff

      # Luau
      luau-lsp
      stylua

      # Nix
      nixd
      nixfmt
    ];

    userSettings = {
      # Force Zed to use Nix's Node instead of downloading an FHS binary
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      languages = {
        Nix = {
          language_servers = [ "nixd" "!nil" ];
          formatter.external = {
            command = "nixfmt";
            arguments = [ "--quiet" "--" ];
          };
        };
        Luau = {
          formatter.external = {
            command = "stylua";
            arguments = [ "-" ];
          };
        };
      };
    };
  };

  # `extraPackages` only puts tools inside Zed's own wrapper.
  # Put anything you also want to run in your normal terminal here:
  home.packages = with pkgs; [
    go
    python3
    ruff
  ];
}
