{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config.show_banner = false

      # Environment variables
      $env.PATH = [
          "/opt/homebrew/sbin",
          "/opt/homebrew/bin",
          "/Users/tylermiller/.nix-profile/bin",
          "/etc/profiles/per-user/tylermiller/bin",
          "/run/current-system/sw/bin",
          "/nix/var/nix/profiles/default/bin",
          "/usr/local/bin",
          "/usr/bin",
          "/bin",
          "/usr/sbin",
          "/sbin"
      ]
      $env.VISUAL = "nvim"
      $env.EDITOR = $env.VISUAL

      alias nv = nvim
      alias lg = lazygit
      # alias cd = z

      # FZF keybindings with previews
      export-env {
        $env.FZF_ALT_C_COMMAND = "fd --type directory --hidden"
        $env.FZF_ALT_C_OPTS = "--preview 'tree -C {} | head -n 200'"
        $env.FZF_CTRL_T_COMMAND = "fd --type file --hidden"
        $env.FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=full --line-range=:500 {}' "
        $env.FZF_DEFAULT_COMMAND = "fd --type file --hidden"
      }

      # Keybindings configuration
      const alt_c = {
          name: fzf_dirs
          modifier: alt
          keycode: char_c
          mode: [emacs, vi_normal, vi_insert]
          event: [
            {
              send: executehostcommand
              cmd: "
                let fzf_alt_c_command = \$\"($env.FZF_ALT_C_COMMAND) | fzf ($env.FZF_ALT_C_OPTS)\";
                let result = nu -c $fzf_alt_c_command;
                cd $result;
              "
            }
          ]
      }

      const ctrl_r = {
        name: history_menu
        modifier: control
        keycode: char_r
        mode: [emacs, vi_insert, vi_normal]
        event: [
          {
            send: executehostcommand
            cmd: "
              let result = history
                | get command
                | str replace --all (char newline) ' '
                | to text
                | fzf --preview 'printf \'{}\' | nufmt --stdin 2>&1 | rg -v ERROR';
              commandline edit --append $result;
              commandline set-cursor --end
            "
          }
        ]
      }

      const ctrl_t =  {
          name: fzf_files
          modifier: control
          keycode: char_t
          mode: [emacs, vi_normal, vi_insert]
          event: [
            {
              send: executehostcommand
              cmd: "
                let fzf_ctrl_t_command = \$\"($env.FZF_CTRL_T_COMMAND) | fzf ($env.FZF_CTRL_T_OPTS)\";
                let result = nu -l -i -c $fzf_ctrl_t_command;
                commandline edit --append $result;
                commandline set-cursor --end
              "
            }
          ]
      }

      export-env {
        if not ($env.__keybindings_loaded? | default false) {
          $env.__keybindings_loaded = true
          $env.config.keybindings = $env.config.keybindings | append [
            $alt_c
            $ctrl_r
            $ctrl_t
          ]
        }
      }

      # Yazi integration
      def --env yy [...args] {
        let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        yazi ...$args --cwd-file $tmp
        let cwd = (open $tmp)
        if $cwd != "" and $cwd != $env.PWD {
          cd $cwd
        }
        rm -fp $tmp
      }
    '';
  };
}
