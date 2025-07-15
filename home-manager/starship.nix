{ pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $directory$custom$all
      '';
      sudo.disabled = true;
      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [ "${pkgs.starship-jj}/bin/starship-jj" "--ignore-working-copy" "starship" ];
        use_stdin = false;
        when = true;
      };
      git_commit.disabled = true;
      git_branch.disabled = true;
    };
    enableFishIntegration = true;
    enableBashIntegration = false;
  };
}
