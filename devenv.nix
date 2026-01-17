{
  pkgs,
  lib,
  config,
  ...
}:
{
  languages = {
    python = {
      enable = true;
      venv = {
        enable = true;
        requirements = ''
          jupyter
          pandas
        '';
      };
    };
    javascript = {
      enable = true;
      npm.enable = true;
    };
  };
  scripts.notebook.exec = "jupyter notebook";
  # See full reference at https://devenv.sh/reference/options/
}
