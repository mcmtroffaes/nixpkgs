{ lib, stdenv, fetchFromGitHub, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "wolfssl";
  version = "4.6.0";

  src = fetchFromGitHub {
    owner = "wolfSSL";
    repo = "wolfssl";
    rev = "v${version}-stable";
    sha256 = "0hk3bnzznxj047gwxdxw2v3w6jqq47996m7g72iwj6c2ai9g6h4m";
  };

  # same as Debian; tracks the published ABI more closely
  configureFlags = [ "--enable-distro --enable-pkcs11 --enable-tls13 --enable-base64encode" ];

  # cyclic reference between wolfssl-config in -dev and libtool's .la file in -lib
  outputs = [ "out" "doc" ];

  nativeBuildInputs = [ autoreconfHook ];

  meta = with lib; {
    description = "A small, fast, portable implementation of TLS/SSL for embedded devices";
    homepage    = "https://www.wolfssl.com/";
    platforms   = platforms.all;
    license = lib.licenses.gpl2;
    maintainers = with maintainers; [ mcmtroffaes ];
  };
}
