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
          set directory "$(fd -t d | fzf)"

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

        zellij attach -c "$name"
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

      # golang
      set -x GOPATH "$HOME/go"
      set -x GOPRIVATE "gitlab.com/*,dev.azure.com/*"
      set -x GOPROXY "direct"
      set -x GO111MODULE "on"
      set -x PATH $PATH $GOPATH/bin

      # ssh agent
      # set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

      # rust + cargo
      set -x PATH $PATH ${config.home.homeDirectory}/.cargo/bin
      set -x PATH $PATH "${config.home.homeDirectory}/.local/bin"
      set -x PATH $PATH "/usr/local/bin"

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
      set -Ux FZF_DEFAULT_OPTS "--color=bg+:#302D41,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"

      # HACK: re-enter the current dir to trigger direnv
      cd ./
    '';
  };

  xdg.configFile."fish/completions/docker.fish".source = "${docker_fish_complete_git}/contrib/completion/fish/docker.fish";
  xdg.configFile."fish/completions/kubectl.fish".source = "${k8s_fish_complete_git}/completions/kubectl.fish";
  xdg.configFile."fish/themes/Catppuccin Mocha.theme".source = "${catppuccin_theme_git}/themes/Catppuccin Mocha.theme";

  programs.starship = {
    enable = true;
    enableNushellIntegration = false;
    settings = {
      add_newline = false;
      format = "╭── $username$hostname$directory$git_branch$git_status$golang$python$php$nodejs$rust $fill $time $line_break╰ $character";
      directory = {
        format = "─── [$path]($style)[$read_only]($read_only_style) ";
        style = "bold white";
        truncation_length = 8;
      };
      time = {
        disabled = false;
        format = "[ $time ]($style) ";
        time_format = "%T";
        style = "#7F849C";
      };
      fill = {
        symbol = "─";
        style = "#11111B";
      };
      git_branch = {
        format = "─── [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold green";
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
        staged = "🚥[\($count\)](green) ";
        renamed = "👅 ";
        deleted = "🗑 [\($count\)](red) ";
      };
      golang = {
        format = "─ [$symbol($version)]($style) ";
      };
      php = {
        format = "─ [$symbol($version)]($style) ";
        symbol = " ";
      };
      python = {
        format = "─ [$symbol$pyenv_prefix($version)(\( $virtualenv\))]($style) ";
      };
      nodejs = {
        format = "─ [$symbol($version)]($style) ";
      };
      rust = {
        format = "─ [$symbol($version)]($style) ";
      };
      nix_shell = {
        format = "─ [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( \($namespace\))]($style) ";
      };
      username = {
        show_always = true;
        format = "[$user]($style) ";
        style_user = "bold white";
      };
      hostname = {
        ssh_only = false;
        format = "on [$hostname]($style) ";
        style = "bold white";
      };
      character = {
        format = "λ ";
      };
    };
  };
}
