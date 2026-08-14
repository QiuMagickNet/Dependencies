#!/bin/bash
set -e

SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
SHARED_PATH="$SCRIPT_PATH/../shared"

# Android NDK settings
unset ANDROID_NDK_HOME
export ANDROID_NDK_HOME="/opt/android-ndk"
TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64"
export TARGET="x86_64-linux-android21"

# Compiler settings
if [[ "${DEBUG_BUILD}" ]]; then
  export FLAGS="-g3 -O0 -fPIC -DDEBUG"
  export CMAKE_BUILD_TYPE="Debug"
  export MESON_BUILD_TYPE="debug"
else
  export FLAGS="-O3 -fPIC -DNDEBUG"
  export CMAKE_BUILD_TYPE="Release"
  export MESON_BUILD_TYPE="release"
fi
export INSTALL_PREFIX="/tmp/dependencies"
export CMAKE_PREFIX_PATH="$INSTALL_PREFIX"
export CPPFLAGS="-I$INSTALL_PREFIX/include"
export LDFLAGS="-L$INSTALL_PREFIX/lib"
export PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig"

# Shared options
export CMAKE_COMMAND="cmake"
export CMAKE_OPTIONS="-DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake -DANDROID_ABI=x86_64 -DANDROID_PLATFORM=android-21 -DANDROID_STL=c++_static"
export CONFIGURE="./configure"
export CONFIGURE_OPTIONS="--host x86_64-linux-android"
export MAKE="make -j$(nproc)"
export MESON_OPTIONS="--cross-file=$SCRIPT_PATH/cross-compilation.meson"
export SED="sed"
export ZIP_OPTIONS="-DENABLE_OPENSSL=OFF -DENABLE_MBEDTLS=OFF -DENABLE_GNUTLS=OFF"

# Library specific options
export DE265_OPTIONS=""
export FFI_OPTIONS="--disable-builddir --host=x86_64-linux-android"
export FONTCONFIG_OPTIONS=""
export HEIF_OPTIONS="-DENABLE_MULTITHREADING_SUPPORT=false"
export JPEGTURBO_OPTIONS="-DWITH_SIMD=0"
export LCMS_OPTIONS=""
export OPENEXR_OPTIONS="-DImath_DIR=$INSTALL_PREFIX/lib/cmake/Imath -Dopenjph_DIR=$INSTALL_PREFIX/lib/cmake/openjph"
export WEBP_OPTIONS="--enable-libwebpmux --enable-libwebpdemux"

# Set compiler for cross-compilation
export CC="$TOOLCHAIN/bin/$TARGET-clang"
export CXX="$TOOLCHAIN/bin/$TARGET-clang++"
export AR="$TOOLCHAIN/bin/llvm-ar"
export RANLIB="$TOOLCHAIN/bin/llvm-ranlib"
export STRIP="$TOOLCHAIN/bin/llvm-strip"

# Build dependencies
$SHARED_PATH/zlib.sh
$SHARED_PATH/lzma.sh
$SHARED_PATH/bzip2.sh
$SHARED_PATH/zip.sh
$SHARED_PATH/xml.sh
$SHARED_PATH/png.sh
$SHARED_PATH/freetype.sh
$SHARED_PATH/fontconfig.sh
$SHARED_PATH/jpeg-turbo.sh
$SHARED_PATH/webp.sh
$SHARED_PATH/tiff.sh
$SHARED_PATH/openjpeg.sh
$SHARED_PATH/lcms.sh
$SHARED_PATH/aom.sh
$SHARED_PATH/de265.sh
$SHARED_PATH/openh264.sh
$SHARED_PATH/heif.sh
$SHARED_PATH/raw.sh
$SHARED_PATH/openjph.sh
$SHARED_PATH/imath.sh
$SHARED_PATH/exr.sh
$SHARED_PATH/ffi.sh
$SHARED_PATH/glib.sh
$SHARED_PATH/lqr.sh
$SHARED_PATH/pixman.sh
$SHARED_PATH/cairo.sh
$SHARED_PATH/fribidi.sh
$SHARED_PATH/harfbuzz.sh
$SHARED_PATH/pango.sh
$SHARED_PATH/croco.sh
$SHARED_PATH/gdk-pixbuf.sh
$SHARED_PATH/rsvg.sh
$SHARED_PATH/raqm.sh
$SHARED_PATH/highway.sh
$SHARED_PATH/brotli.sh
$SHARED_PATH/jpeg-xl.sh