{ stdenvNoCC, lib, fetchzip, jdk
, lang ? "de" # Supports de,dk,en,es,fi,fr,it,no,ru,se,zh
, dataDir ? "~/.local/share/rechnungsverwalter"
, extraJavaOpts ? ""
}:

stdenvNoCC.mkDerivation rec {
  name = "rechnungsverwalter";
  version = "2.10.58";

  src = fetchzip {
    url = "https://rechnungsverwalter.de/files/rv_install_V${version}_all_portatibel.zip";
    hash = "sha256-9DvJbmh25Jn0dYLpUa2PKiptLamN4Ig9O6t6sNfZJ+c=";
    stripRoot = false;
  };

  dontBuild = true;

  # This starts in jdk8, clean up the script and maybe try some later versions
  # Move lib to $out/share/java?
  installPhase = ''
    runHook preInstall

    rm start_*.{bat,sh}
    chmod +x rechnungsverwalter.jar
    cp -r . $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "Java application for creating and managing invoices";
    homepage = [
      "https://rechnungsverwalter.de/"
      "http://invoice-create.com/"
    ];
    downloadPage = "https://rechnungsverwalter.de/herunterladen.html";
    license = licenses.unfree;
    inherit (jdk.meta) platforms;
  };
}
