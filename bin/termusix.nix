{ stdenv, lib, fetchurl, runTimePackage  }:

stdenv.mkDerivation rec {
  pname = "termusix";
  version = "0.1.1";

  src = fetchurl {
    url = "https://github.com/sumoduduk/termusix/releases/download/${version}/termusix-x86_64-linux";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/
  '';

  propagatedBuildInputs = [ runTimePackage ]

  meta = with lib; {
    description = "A terminal-based music player with a user-friendly terminal UI, built with Rust.";
    homepage = "https://github.com/sumoduduk/termusix";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
