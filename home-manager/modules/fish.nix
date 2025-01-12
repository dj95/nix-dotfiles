{
  config,
  pkgs,
  libs,
  ...
}:
let
  k8s_fish_complete_git = pkgs.fetchgit {
    url = "https://github.com/evanlucas/fish-kubectl-completions";
    rev = "ced676392575d618d8b80b3895cdc3159be3f628";
    sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
  };

  docker_fish_complete_git = pkgs.fetchgit {
    url = "https://github.com/docker/cli";
    rev = "dfb36eaef8729914749500b148649e05ceeddd03";
    sha256 = "sha256-/KkvUGwFKPWKWTE/7Nw0k6L+SaXhlw3fYJUjOzxvz3Y=";
  };

  catppuccin_theme_git = pkgs.fetchgit {
    url = "https://github.com/catppuccin/fish";
    rev = "b90966686068b5ebc9f80e5b90fdf8c02ee7a0ba";
    sha256 = "sha256-wQlYQyqklU/79K2OXRZXg5LvuIugK7vhHgpahpLFaOw=";
  };

  gruvbox_theme_git = pkgs.fetchgit {
    url = "https://github.com/sujaybokil/fish-gruvbox";
    rev = "5556465864fdc0ad69c6bec47e730be02ff984a5";
    sha256 = "sha256-Xy9A6ksrA5Bon08y4qOOfyWHYcwds0Sp560pK7XY1OY=";
  };

  rosepine_theme_git = pkgs.fetchgit {
    url = "https://github.com/rose-pine/fish";
    rev = "38aab5baabefea1bc7e560ba3fbdb53cb91a6186";
    sha256 = "sha256-bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
  };

  goose = pkgs.fetchgit {
    url = "https://github.com/raesene/goose_effects";
    rev = "938284b1eaa2b35e5721893afd00d600049a2870";
    sha256 = "sha256-9ReScULUlXTs3G8mQ32qLtLxuVwp4ErUrCS7fm2mCuc=";
  };
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      kctx = "${pkgs.kubectx}/bin/kubectx";
      kns = "${pkgs.kubectx}/bin/kubens";
      kqc = "${pkgs.kustomize-quick-create}/bin/kustomize-quick-create";
      ls = "${pkgs.eza}/bin/eza --icons";
      vim = "nvim";
      zj = "${pkgs.zellij}/bin/zellij";
    };

    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "3ee95536106c11073d6ff466c1681cde31001383";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }
      {
        name = "direnv";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-direnv";
          rev = "0221a4d9080b5f492f1b56ff7b2dc6287f58d47f";
          sha256 = "50tMKwtXtJBpgZ42JfJKyIWgusu4xZ9/yCiGKDfqyhE=";
        };
      }
      {
        name = "ssh_agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
          sha256 = "e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
        };
      }
      {
        name = "theme_gruvbox";
        src = pkgs.fetchFromGitHub {
          owner = "tomyun";
          repo = "base16-fish";
          rev = "2f6dd973a9075dabccd26f1cded09508180bf5fe";
          sha256 = "sha256-PebymhVYbL8trDVVXxCvZgc0S5VxI7I1Hv4RMSquTpA=";
        };
      }
    ];

    functions = {
      goose = {
        body = ''
          tte -i ${goose}/base_goose.txt decrypt --typing-speed 5 --final-gradient-stops 326CE5
        '';
      };
      k = {
        wraps = "${pkgs.kubectl}/bin/kubectl";
        body = ''
          command kubecolor $argv
        '';
      };
      kbkp = ''
        set namespace "$argv[1]"

        set dest ( printf "%s/%s_%s" $PWD ( date +'%Y%m%d_%H%M' ) "$namespace" )

        if test -e "$dest"
            printf ":: backup dir exists. Refusing to overwrite it!\n"
            printf ":: backup dir: %s\n" "$dest"

            exit 2
        end

        mkdir "$dest"

        printf ":: backing up to: %s\n" "$dest"

        set resources pv pvc configmap ingress service secret deployment statefulset daemonsets hpa job cronjob postgresql

        for resource in $resources
            printf ":: %s :: backing up: %s\n" "$namespace" "$resource"

            kubectl -n "$namespace" get "$resource" -oyaml > "$dest/$resource.yaml"
        end
      '';
      dev = ''
        set workspace (pwd)
        set name "$argv[1]"

        if [ "$name" = "" ]
          pushd ~/Developer
          set directory "$(fd -t d | fzf --preview 'bash -c "[[ -f {}/README.md ]] && glow {}/README.md || eza -l --icons --color=always --no-time {}"')"

          if [ "$directory" = "" ]
            return
          end

          set workspace "$(pwd)/$directory"
          set name (echo -n "$workspace" | rev | cut -d'/' -f2 | rev | sed -re 's/\./_/g')
          popd
        end

        cd "$workspace"

        if [ -e "$workspace/.zellij.kdl" ]
          zellij --layout "$workspace/.zellij.kdl" attach -c "$name"

          return
        end

        set cols (tput cols)
        set rows (tput lines)
        set ratio (math $cols / $rows)

        set layout "default"

        if [ $ratio -gt 8.0 ]
          set layout "wide"
        end

        zellij --layout "$layout" attach -c "$name"
      '';
      direnvim = ''
        eval (${pkgs.direnv}/bin/direnv export fish)

        direnv exec . nvim
      '';
      notify = ''
        osascript -e "display notification \"$argv[1]\" with title \"Notify\""
      '';
      znotify = ''
        zellij pipe -n zjstatus "zjstatus::notify::$argv[1]"
      '';
      git-latest-tag = ''
        set revlist (git rev-list --tags --max-count=1)
        git describe --tags $revlist'';
      fish_greeting = '''';
    };

    shellInit = ''
      # set the editor
      set -x EDITOR "nvim"
      set -x XDG_CONFIG_HOME "/Users/daniel/.config"

      # golang
      set -x GOPATH "$HOME/go"
      set -x GOPRIVATE "gitlab.com/*,dev.azure.com/*"
      set -x GOPROXY "direct"
      set -x GO111MODULE "on"
      set -x PATH $PATH $GOPATH/bin

      # tofu
      set -x TF_PLUGIN_CACHE_DIR "/Users/daniel/.tf-cache"

      # rust + cargo
      set -x PATH $PATH ${config.home.homeDirectory}/.cargo/bin
      set -x PATH $PATH "${config.home.homeDirectory}/.local/bin"
      set -x PATH $PATH "/usr/local/bin"
      set -x PATH $PATH "/opt/homebrew/bin"

      # latex
      set -x PATH $PATH "/Library/TeX/texbin"

      # emacs
      set -x PATH $PATH "$HOME/.emacs.d/bin"

      # krew
      set -gx PATH $PATH "$HOME/.krew/bin"

      # fix rustfmt under macos
      set -x DYLD_LIBRARY_PATH $DYLD_LIBRARY_PATH (rustc --print sysroot)/lib

      # use docker buildkit
      set -x DOCKER_BUILDKIT 1
      set -x COMPOSE_DOCKER_CLI_BUILD 1
      set -x DOCKER_HOST "unix:///${config.home.homeDirectory}/.colima/docker.sock"

      # kubernetes
      set -x KUBECTL_EXTERNAL_DIFF "difft"

      # nix
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      # home-manager
      if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
          fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
      end

      # use the catppuccin theme
      # fish_config theme choose 'Catppuccin Mocha'
      # base16-gruvbox-dark-medium

      # fzf colors
      # set -Ux FZF_DEFAULT_OPTS "\
      #     --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      #     --color=fg:#fbf1c7,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      #     --color=marker:#d5c4a1,fg+:#fbf1c7,prompt:#cba6f7,hl+:#f38ba8 \
      #     --color=selected-bg:#45475a \
      #     --multi"

      set -Ux FZF_DEFAULT_OPTS "\
        --color=fg:#ebdbb2,hl:#b16286 \
        --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b \
        --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 \
        --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f"

      # HACK: re-enter the current dir to trigger direnv
      cd ./
    '';
  };

  xdg.configFile."fish/completions/docker.fish".source = "${docker_fish_complete_git}/contrib/completion/fish/docker.fish";
  xdg.configFile."fish/completions/kubectl.fish".source = "${k8s_fish_complete_git}/completions/kubectl.fish";
  xdg.configFile."fish/themes/Catppuccin Mocha.theme".source = "${catppuccin_theme_git}/themes/Catppuccin Mocha.theme";
  xdg.configFile."fish/themes/Rose Pine.theme".source = "${rosepine_theme_git}/themes/Rosé Pine.theme";

  programs.starship = {
    enable = true;
    enableNushellIntegration = false;
    settings = {
      add_newline = false;
      format = "[╭──](#d5c4a1) $username$hostname$directory$git_branch$git_status$golang$python$php$nodejs$rust $fill $time $line_break[╰](#d5c4a1) $character";
      directory = {
        format = "[───](#d5c4a1) [$path]($style)[$read_only]($read_only_style) ";
        style = "bold #fbf1c7";
        truncation_length = 8;
      };
      time = {
        disabled = false;
        format = "[ $time ]($style) ";
        time_format = "%T";
        style = "#fbf1c7";
      };
      fill = {
        symbol = "─";
        style = "#665c54";
      };
      git_branch = {
        format = "[───](#d5c4a1) [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold #d5c4a1";
        symbol = "";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        conflicted = "🤮 ";
        ahead = "👆 ";
        behind = "👇 ";
        diverged = "🚧 ";
        up_to_date = "👍 ";
        untracked = "🔍[\($count)\](blue) ";
        stashed = "📦 ";
        modified = "💩[\($count\)](yellow) ";
        staged = "🚥[\($count\)](#d5c4a1) ";
        renamed = "👅 ";
        deleted = "🗑 [\($count\)](red) ";
      };
      golang = {
        format = "[─](#d5c4a1) [$symbol($version)]($style) ";
      };
      php = {
        format = "[─](#d5c4a1) [$symbol($version)]($style) ";
        symbol = " ";
      };
      python = {
        format = "[─](#d5c4a1) [$symbol$pyenv_prefix($version)(\( $virtualenv\))]($style) ";
      };
      nodejs = {
        format = "[─](#d5c4a1) [$symbol($version)]($style) ";
      };
      rust = {
        format = "[─](#d5c4a1) [$symbol($version)]($style) ";
      };
      nix_shell = {
        format = "[─](#d5c4a1) [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( \($namespace\))]($style) ";
      };
      username = {
        show_always = true;
        format = "[$user]($style) ";
        style_user = "bold #fbf1c7";
      };
      hostname = {
        ssh_only = false;
        format = "[on](#d5c4a1) [$hostname]($style) ";
        style = "bold #fbf1c7";
      };
      character = {
        format = "[λ](#fbf1c7) ";
      };
    };
  };
}
