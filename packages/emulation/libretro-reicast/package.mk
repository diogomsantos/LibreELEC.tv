# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-reicast"
PKG_VERSION="e7181d4"
PKG_SHA256="c003d674225a8787665d0bb040fbd569f8f64e1081031d33243a95b73dd4e8f9"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/reicast-emulator"
PKG_URL="https://github.com/libretro/reicast-emulator/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="reicast-emulator-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Reicast is a multiplatform Sega Dreamcast emulator"
PKG_LONGDESC="Reicast is a multiplatform Sega Dreamcast emulator"

PKG_LIBNAME="reicast_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="REICAST_LIB"

make_target() {
  if [ "$DEVICE" = "RPi2" ]; then
    make platform=${DEVICE,,}
  else
    case $TARGET_CPU in
      arm1176jzf-s)
        make platform=arm FORCE_GLES=1
        ;;
      cortex-a7|cortex-a9)
        make platform=armv7-neon-hardfloat-$TARGET_CPU FORCE_GLES=1
        ;;
      x86-64)
        make
        ;;
    esac
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
