{
  pkgs,
  config,
  lib,
  ...
}:

{

  options = {
    modules.school.enable = lib.mkEnableOption "school module";
    modules.school.wifi = lib.mkEnableOption "the installation of Eduroam certs. If you need to use the Eduroam WIFI, set this to true.";
  };

  config = lib.mkIf config.modules.school.enable {

    # to connect to the Eduroam WIFI, it is necessary to install these certificates
    security.pki.certificateFiles = lib.mkIf config.modules.school.wifi [
      ./assets/eduroam/DigiCertGlobalRootCA.pem
      ./assets/eduroam/DigiCertTLSRSASHA2562020CA1-1.pem
    ];
  };
}
