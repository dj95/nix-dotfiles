{ config, pkgs, libs, ... }:
let
  k8s_fish_complete_git = pkgs.fetchgit {
    url = "https://github.com/evanlucas/fish-kubectl-completions";
    rev = "bbe3b831bcf8c0511fceb0607e4e7511c73e8c71";
    sha256 = "+jo6Zx6nlA5QhQ+3Vru+QbKjCwIxPEvrlKWctffG3OQ=";
  };
in {
  home.packages = with pkgs; [
    vivid
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      k = "${pkgs.kubectl}/bin/kubectl";
      ls = "${pkgs.coreutils}/bin/ls --color=auto";
      vim = "${pkgs.neovim}/bin/nvim";
    };

    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
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
        name = "fish-color-scheme-switcher";
        src = pkgs.fetchFromGitHub {
          owner = "dj95";
          repo = "fish-color-scheme-switcher";
          rev = "0afe7cdfb222ae4e8581675c9cfc4ef720b738b6";
          sha256 = "cEZz+Dxn3oGoUPDaqFo5x59G3OnjxjgUfxABD/ijvXs=";
        };
      }
    ];

    functions = {
      composer_legacy = ''
    docker run --rm -it -v $PWD:/app:z -w /app compauth $argv
'';
      dev = ''
    set workspace (pwd)
    set name "$argv[1]"

    tmuxinator start dev name="$name" workspace="$workspace"
'';
      fish_greeting = '''';
      fish_prompt = ''
    # default color
    set color normal

    # red prompt on error
    if test $status -ne 0
        set color purple
    end

    # yellow prompt on C-c
    if test $status -eq 130
        set color yellow
    end

    # Get the git directory for later use.
    # Return if not inside a Git repository work tree.
    set seperator "┄┄┄"
    if not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
        set seperator ""
    end

    # print the prompt
    printf '%s╭─┄ %s%s@%s %s┄┄┄ %s%s %s %s\n' \
        (set_color $color) \
        (set_color normal) (whoami) (hostname) \
        (set_color $color) \
        (set_color normal) (prompt_pwd) \
        (printf $seperator) \
        (__fish_git_prompt "%s")
    printf '%s╰ %sλ ' \
        (set_color $color) \
        (set_color normal)

    # reset the color back to normal
    set_color normal
'';
      fish_mode_prompt = '''';
      fish_right_prompt = '''';
      set_ssh_agent = ''
    set -x SSH_ENV $HOME/.ssh/environment

    start_ssh_agent

    test_identities
'';
      start_ssh_agent = ''
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end

    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null

    if [ $status -ne 0 ]
        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    end

    chmod 600 $SSH_ENV

    . $SSH_ENV > /dev/null
'';
      test_identities = ''
    ssh-add -l | grep "The agent has no identities" > /dev/null

    if [ $status -eq 0 ]
        ssh-add ~/.ssh/id_rsa 2>&1 > /dev/null
    end
'';
    };

    promptInit = ''
# Options
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "auto"

# Colors
set green (set_color green)
set magenta (set_color magenta)
set normal (set_color normal)
set red (set_color red)
set yellow (set_color yellow)

set __fish_git_prompt_color_branch green --bold
set __fish_git_prompt_color_dirtystate magenta
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red


# Icons
set __fish_git_prompt_char_cleanstate ' 👍'
set __fish_git_prompt_char_conflictedstate ' ⚠️ '
set __fish_git_prompt_char_dirtystate ' 💩'
set __fish_git_prompt_char_invalidstate ' 🤮'
set __fish_git_prompt_char_stagedstate ' 🚥'
set __fish_git_prompt_char_stashstate ' 📦 '
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_untrackedfiles ' 🔍'
set __fish_git_prompt_char_upstream_ahead ' ☝️ '
set __fish_git_prompt_char_upstream_behind ' 👇'
set __fish_git_prompt_char_upstream_diverged ' 🚧'
set __fish_git_prompt_char_upstream_equal ' 💯'
'';

    shellInit = ''
# set the editor
set -x EDITOR "nvim"
# set -x TERM "xterm-256color"

# golang
set -x GOPATH "$HOME/go"
set -x GOPRIVATE "gitlab.com/*,dev.azure.com/*"
set -x GOPROXY "direct"
set -x GO111MODULE "on"
set -x PATH $PATH $GOPATH/bin

# ssh agent
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# rust + cargo
set -x PATH $PATH ${config.home.homeDirectory}/.cargo/bin
set -x PATH $PATH "${config.home.homeDirectory}/.local/bin"
set -x PATH $PATH "/usr/local/bin"

# latex
set -x PATH $PATH "/Library/TeX/texbin"

# emacs
set -x PATH $PATH "$HOME/.emacs.d/bin"

# use docker buildkit
set -x DOCKER_BUILDKIT 1
set -x COMPOSE_DOCKER_CLI_BUILD 1

# nix
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
end

# home-manager
if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
    fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
end

# ls with colors
set -x LS_COLORS ( ${pkgs.vivid}/bin/vivid generate ayu )

# theme
set -U fish_color_normal normal
set -U fish_color_command 000000
set -U fish_color_quote 666A80
set -U fish_color_redirection 585858
set -U fish_color_end 969696
set -U fish_color_error FFA779
set -U fish_color_param 5f00d7
set -U fish_color_comment B0B0B0
set -U fish_color_match normal
set -U fish_color_selection c0c0c0
set -U fish_color_search_match ffff00
set -U fish_color_history_current normal
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd 008000
set -U fish_color_cwd_root 800000
set -U fish_color_valid_path normal
set -U fish_color_autosuggestion 00af00
set -U fish_color_user 00ff00
set -U fish_color_host normal
set -U fish_color_cancel normal
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
'';
  };

  xdg.configFile."fish/fish_variables".source = ../configs/fish/fish_variables;
  xdg.configFile."fish/completions/kubectl.fish".source = "${k8s_fish_complete_git}/completions/kubectl.fish";
}
