# modules/pi.nix
{ pkgs, inputs, ... }: {
  environment.systemPackages = [
    pkgs.bubblewrap
    pkgs.ripgrep
    pkgs.mcp-nixos
    pkgs.socat
    pkgs.python3
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.rtk
    (pkgs.symlinkJoin {
      name = "pi-with-extensions";
      paths = [ pkgs.pi-coding-agent ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/pi \
          --run 'export NPM_CONFIG_PREFIX="$HOME/.pi/npm"' \
          --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
      '';
    })
  ];
}
