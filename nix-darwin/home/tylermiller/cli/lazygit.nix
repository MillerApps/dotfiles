{
  programs = {
    lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            key = "E";
            description = "Add empty commit";
            context = "commits";
            prompts = [
              {
                type = "input";
                title = "Enter commit message";
                initialValue = "";
                key = "message";
              }
            ];
            command = "git commit --allow-empty -m 'empty: {{.Form.message}}'";
            loadingText = "Committing empty commit...";
          }
        ];
        gui = {
          theme = {
            activeBorderColor = ["#fab387" "bold"];
            inactiveBorderColor = ["#a6adc8"];
            optionsTextColor = ["#89b4fa"];
            selectedLineBgColor = ["#313244"];
            cherryPickedCommitBgColor = ["#45475a"];
            cherryPickedCommitFgColor = ["#fab387"];
            unstagedChangesColor = ["#f38ba8"];
            defaultFgColor = ["#cdd6f4"];
            searchingActiveBorderColor = ["#f9e2af"];
            authorColors = ["*" "#b4befe"];
          };
        };
      };
    };
  };
}
