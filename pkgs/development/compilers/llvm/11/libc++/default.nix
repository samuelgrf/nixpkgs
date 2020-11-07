{ lib, stdenv, fetch, cmake, python3, libcxxabi, llvm, fixDarwinDylibNames, version
, enableShared ? true
, fetchFromGitHub
}:

stdenv.mkDerivation {
  pname = "libc++";
  inherit version;

  /*src = fetch "libcxx" "0ylbkcd38zrrz9xmkq9na3d9s8d96hc286dwfwd73wi205lyc7kc";

  postUnpack = ''
    unpackFile ${libcxxabi.src}
    mv libcxxabi-* libcxxabi
    unpackFile ${llvm.src}
    mv llvm-* llvm
  '';*/

  src = fetchFromGitHub {
    owner = "llvm";
    repo = "llvm-project";
    rev = "a1caa302970de86b15d360212b526be8f1d59641";
    sha256 = "1j3z3ra9dp5jlfdfncq6y279dkb68xfr5mf5286db69i57zfdxjc";
  };

  # NOTE This file isn't actually evualated when building chromium.
  postUnpack = ''
    cp -r $src/llvm/. .
    cp -r $src/libcxxabi/. .
  '';

  patches = stdenv.lib.optional stdenv.hostPlatform.isMusl ../../libcxx-0001-musl-hacks.patch;

  preConfigure = lib.optionalString stdenv.hostPlatform.isMusl ''
    patchShebangs utils/cat_files.py
  '';

  nativeBuildInputs = [ cmake python3 ]
    ++ lib.optional stdenv.isDarwin fixDarwinDylibNames;

  buildInputs = [ libcxxabi ];

  cmakeFlags = [
    "-DLIBCXX_CXX_ABI=libcxxabi"
  ] ++ stdenv.lib.optional (stdenv.hostPlatform.isMusl || stdenv.hostPlatform.isWasi) "-DLIBCXX_HAS_MUSL_LIBC=1"
    ++ stdenv.lib.optional (stdenv.hostPlatform.useLLVM or false) "-DLIBCXX_USE_COMPILER_RT=ON"
    ++ stdenv.lib.optional stdenv.hostPlatform.isWasm [
      "-DLIBCXX_ENABLE_THREADS=OFF"
      "-DLIBCXX_ENABLE_FILESYSTEM=OFF"
      "-DLIBCXX_ENABLE_EXCEPTIONS=OFF"
    ] ++ stdenv.lib.optional (!enableShared) "-DLIBCXX_ENABLE_SHARED=OFF";

  enableParallelBuilding = true;

  passthru = {
    isLLVM = true;
  };

  meta = {
    homepage = "https://libcxx.llvm.org/";
    description = "A new implementation of the C++ standard library, targeting C++11";
    license = with stdenv.lib.licenses; [ ncsa mit ];
    platforms = stdenv.lib.platforms.all;
  };
}
