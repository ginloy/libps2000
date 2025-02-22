 { pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "libps2000";
  src = pkgs.fetchurl {
    url = "https://labs.picotech.com/picoscope7/debian/pool/main/libp/libps2000/libps2000_3.0.146-3r6147_amd64.deb";
    sha256 = "sha256-+H5+UV/5ZXg2Zj2WEMFxe9XfEcCeHM30OVMOjfeZSfM=";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    libusb1
    pkgs.stdenv.cc.cc.lib
  ];

  sourceRoot = ".";
  unpackCmd = "dpkg-deb -x $src .";
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    cp -r opt/picoscope/lib/* $out/lib
    cp -r opt/picoscope/include/* $out/include
  '';
} 
