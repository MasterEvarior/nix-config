{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.onedrive pkgs.zotero ];


  environment.etc."config" = {
    target="onedrive/config";
    source=./config;
  };

  #to connect to the Eduroam WIFI, it is necessary to install these certificates
  security.pki.certificateFiles =
    [ ./DigiCertGlobalRootCA.pem ./DigiCertTLSRSASHA2562020CA1-1.pem ];
}
