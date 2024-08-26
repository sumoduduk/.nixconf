{
  stdenv,
  lib,
  fetchurl,
  makeWrapper,
  alsa-lib,
  libx11,
  libxtst,
  libxcb,
  libxkbcommon,
  libxkbcommon-x11,
  libayatana-appindicator,
  libayatana-indicator,
  ayatana-ido,
  libdbusmenu-glib,
  gtk3,
  pango,
  harfbuzz,
  at-spi2-core,
  cairo,
  gdk-pixbuf,
  libglvnd,
  libxrandr,
  libxxf86vm,
  libxi,
  libxcursor,
  libxinerama,
}:
stdenv.mkDerivation rec {
  pname = "realneptune";
  version = "1.0.2";

  src = fetchurl {
    url = "https://github.com/M1ndo/Neptune/releases/download/v${version}/Neptune.tar.xz";
    sha256 = "000000000000000000000000000000000000000000000000000";
  };

  nativeBuildInputs = [makeWrapper];

  buildInputs = [
    alsa-lib
    libx11
    libxtst
    libxcb
    libxkbcommon
    libxkbcommon-x11
    libayatana-appindicator
    libayatana-indicator
    ayatana-ido
    libdbusmenu-glib
    gtk3
    pango
    harfbuzz
    at-spi2-core
    cairo
    gdk-pixbuf
    libglvnd
    libxrandr
    libxxf86vm
    libxi
    libxcursor
    libxinerama
  ];

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out/
    makeWrapper $out/Neptune $out/bin/Neptune
  '';

  meta = with lib; {
    description = "Neptune a superfast mechanical keyboard sound app";
    homepage = "https://github.com/M1ndo/Neptune";
    license = licenses.agpl3;
    platforms = platforms.linux;
  };
}
