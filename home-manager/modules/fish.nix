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

      # ssh agent
      # set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

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
      fish_config theme choose 'Catppuccin Mocha'

      # fzf colors
      set -Ux FZF_DEFAULT_OPTS "\
          --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
          --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
          --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
          --color=selected-bg:#45475a \
          --multi"
    # set -Ux FZF_DEFAULT_OPTS "
    #       --color=fg:#908caa,hl:#ebbcba
    #       --color=fg+:#e0def4,hl+:#ebbcba
    #       --color=border:#403d52,header:#31748f,gutter:#191724
    #       --color=spinner:#f6c177,info:#9ccfd8
    #       --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

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
      format = "[╭──](#b4befe) $username$hostname$directory$git_branch$git_status$golang$python$php$nodejs$rust $fill $time $line_break[╰](#b4befe) $character";
      directory = {
        format = "[───](#b4befe) [$path]($style)[$read_only]($read_only_style) ";
        style = "bold #cdd6f4";
        truncation_length = 8;
      };
      time = {
        disabled = false;
        format = "[ $time ]($style) ";
        time_format = "%T";
        style = "#cdd6f4";
      };
      fill = {
        symbol = "─";
        style = "#45475a";
      };
      git_branch = {
        format = "[───](#b4befe) [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold #b4befe";
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
        staged = "🚥[\($count\)](#b4befe) ";
        renamed = "👅 ";
        deleted = "🗑 [\($count\)](red) ";
      };
      golang = {
        format = "[─](#b4befe) [$symbol($version)]($style) ";
      };
      php = {
        format = "[─](#b4befe) [$symbol($version)]($style) ";
        symbol = " ";
      };
      python = {
        format = "[─](#b4befe) [$symbol$pyenv_prefix($version)(\( $virtualenv\))]($style) ";
      };
      nodejs = {
        format = "[─](#b4befe) [$symbol($version)]($style) ";
      };
      rust = {
        format = "[─](#b4befe) [$symbol($version)]($style) ";
      };
      nix_shell = {
        format = "[─](#b4befe) [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( \($namespace\))]($style) ";
      };
      username = {
        show_always = true;
        format = "[$user]($style) ";
        style_user = "bold #cdd6f4";
      };
      hostname = {
        ssh_only = false;
        format = "[on](#b4befe) [$hostname]($style) ";
        style = "bold #cdd6f4";
      };
      character = {
        format = "[λ](#cdd6f4) ";
      };
    };
  };
}
