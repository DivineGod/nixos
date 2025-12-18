# home.nix - NixOS module that configures Home Manager
{ config, pkgs, specialArgs, ... }:

{
  home-manager.users.${specialArgs.username} = { config, ... }: {
    home.stateVersion = specialArgs.stateVersion; # Ensure this matches your NixOS version or desired HM version
    xdg.userDirs.enable = true;
    xdg.userDirs.createDirectories = true;

    home.packages = with pkgs; [
      noto-fonts-color-emoji
      fira-code
      nerd-fonts.fira-code
      nerd-fonts.atkynson-mono
    ];

    # Font configuration for Home Manager
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "iAtkinsonHyperlegibleMono Nerd Font Mono" "FiraCode Nerd Font Mono"  "monospace" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    programs.home-manager.enable = true;

    programs.bat = {
      enable = true;
      config = {
        theme = "dayfox";
      };
      themes = {
        dayfox = {
          src = pkgs.fetchFromGitHub {
            owner = "EdenEast";
            repo = "nightfox.nvim";
            rev = "ba47d4b4c5ec308718641ba7402c143836f35aa9";
            hash = "sha256-HoZEwncrUnypWxyB+XR0UQDv+tNu1/NbvimxYGb7qu8=";
          };
          file = "extra/dayfox/dayfox.tmTheme";
        };
      };
    };
    programs.eza.enable = true;
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.zellij = {
      enable = true;

      enableFishIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = true;
      settings.theme = "dayfox";
    };

    programs.git = {
      enable = true;
      settings = {
        user.name = specialArgs.gitUsername; # Access from specialArgs
        user.email = specialArgs.gitUseremail; # Access from specialArgs
      
        init.defaultBranch = "main";
      };
    };
    programs.mergiraf.enable = true;

    programs.jujutsu.enable = true;
    programs.jq.enable = true;

    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
    xdg.configFile."fish/functions".source = ./home/fish/functions; # Make sure to add the files to the git index before running `home-manager switch`
    xdg.configFile."fish/functions".recursive = true;

    programs.alacritty = {
      enable = true;
      theme = "dayfox";
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };

}
