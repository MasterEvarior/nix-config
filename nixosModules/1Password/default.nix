{
  security.polkit.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "giannin"
      "work"
    ];
  };

  programs._1password = {
    enable = true;
  };

  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      firefox
      .zen-wrapped
    '';
    mode = "0755";
  };
}
