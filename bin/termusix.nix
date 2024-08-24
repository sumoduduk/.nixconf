{
  stdenv,
  lib,
  fetchurl,
  runTimePackage,
}:
stdenv.mkDerivation rec {
  pname = "termusix";
  version = "0.1.1";

  src = fetchurl {
    url = "https://github.com/sumoduduk/termusix/releases/download/v${version}/termusix-x86_64-linux";
    sha256 = "sha256-hAhDpzjv7MXhfevgKAGmnt8Wp37mFMBNyGboTyLEJgw=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/
  '';

  propagatedBuildInputs = [runTimePackage];

  meta = with lib; {
    description = "A terminal-based music player with a user-friendly terminal UI, built with Rust.";
    homepage = "https://github.com/sumoduduk/termusix";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
