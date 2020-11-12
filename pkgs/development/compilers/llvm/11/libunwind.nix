{ stdenv, version, buildOverride, fetch, cmake, fetchpatch, enableShared ? true }:

stdenv.mkDerivation rec {
  pname = "libunwind";
  inherit version;

  src = fetch pname "0bwjd2xf51r2apn8p0f9shb6nc8hnqzq1n9gggjvyjmi6cf02mc4";

  unpackPhase =
    if buildOverride == null then null
    else ''
      cp -r $src/libunwind/. .
      chmod -R u+w .
    '';

  nativeBuildInputs = [ cmake ];

  enableParallelBuilding = true;

  cmakeFlags = stdenv.lib.optional (!enableShared) "-DLIBUNWIND_ENABLE_SHARED=OFF";
}
