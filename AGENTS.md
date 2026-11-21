- NEVER run nixos-rebuild switch/boot/test. Allowed: nix flake check,
  nix eval, nixos-rebuild dry-build, nixos-rebuild build.
- NEVER read /run/secrets, ~/.config/sops, ~/.ssh, or decrypt anything.
- secrets/*.yaml are encrypted blobs: edit structure only, never plaintext.
- Commit before and after each change. Small diffs, one concern per commit.
- Verify every option/package via the nixos MCP tools before use, e.g.
  nix(action="info", query="programs.git", source="nixos").
- Use nix(action="flake-inputs", ...) to inspect our pinned inputs.
MCP nix tool syntax:
- info works on LEAF options only; for subtrees use action=search type=options.
- Wildcards are <name>, not *: users.users.<name>.extraGroups.
- channel is "unstable"/"stable", NOT "nixos-unstable".
- browse is only for home-manager/darwin/nixvim/nvf/noogle, never nixos.
- sops.* options are external (sops-nix); not in the nixos DB — verify via the pinned source.
- nix tool: argv[0] MUST be the binary name.
  Use ["nix","eval",".#..."], ["nix","flake","check"],
  ["nixos-rebuild","build","--flake",".#nixos"].
  Never ["eval",...] — prepend the binary.
