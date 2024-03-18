{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.onedrive ];

  #to connect to the Eduroam WIFI, it is necessary to install these certificates
  security.pki.certificateFiles =
    [ ./DigiCertGlobalRootCA.crt ./DigiCertTLSRSASHA2562020CA1-1.crt ];
}
