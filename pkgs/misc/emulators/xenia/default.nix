{ fetchFromGitHub
, gtk3
, llvmPackages_9
, lz4
, pkg-config
, python3
, SDL2
, vulkan-headers
, vulkan-loader
}:

let
  stdenv = llvmPackages_9.libcxxStdenv;
in

stdenv.mkDerivation {
  pname = "xenia";
  version = "unstable-2021-01-04";

  src = fetchFromGitHub {
    owner = "xenia-project";
    repo = "xenia";
    rev = "9a74df491ffd0189ddd26bc2030e0eae6a775f4e";
    sha256 = "106dkcnsc7ibx0c8fa8csp49dz59s9d4k6hxm4lybf3lybq0l491";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    llvmPackages_9.bintools
    pkg-config
    python3
  ];

  buildInputs = [
    gtk3
    lz4
    SDL2
    vulkan-headers
    vulkan-loader
  ];

  patchPhase = ''
    runHook prePatch

    # Fixes "fatal error: 'sys/sysctl.h' file not found"
    substituteInPlace third_party/libav/config_lin.h \
      --replace "#define HAVE_SYSCTL 1" "#define HAVE_SYSCTL 0"

    runHook postPatch
  '';

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    # TODO Look into using 'setup' argument
    python3 xenia-build build --config release -j $NIX_BUILD_CORES

    runHook postBuild
  '';

  NIX_CFLAGS_COMPILE = "-Wno-error-unused-result";

  enableParallelBuilding = true;
}
