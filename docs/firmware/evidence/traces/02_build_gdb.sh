#!/usr/bin/env bash
set -euo pipefail

VER=15.2
SRC=/root/src
BUILD=/root/build-bfin
PREFIX=/opt/bfin
LOGC="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim/build.log"

mkdir -p "$SRC" "$BUILD"
cd "$SRC"

if [ ! -f "gdb-${VER}.tar.xz" ]; then
  echo "[*] downloading gdb-${VER}.tar.xz"
  wget -q "https://ftp.gnu.org/gnu/gdb/gdb-${VER}.tar.xz"
fi

if [ ! -d "gdb-${VER}" ]; then
  echo "[*] extracting"
  tar xf "gdb-${VER}.tar.xz"
fi

cd "$BUILD"
if [ ! -f Makefile ]; then
  echo "[*] configure"
  "${SRC}/gdb-${VER}/configure" \
    --target=bfin-elf \
    --prefix="${PREFIX}" \
    --enable-sim \
    --disable-gdbserver \
    --disable-werror \
    --disable-nls \
    --with-python=no \
    --without-guile \
    --disable-tui
fi

echo "[*] make (this takes a while)"
make -j8

echo "[*] make install"
make install

echo "=== BUILD OK ==="
ls -la "${PREFIX}/bin" | grep -E 'bfin-elf-(run|gdb|objdump|ld)' || true
"${PREFIX}/bin/bfin-elf-run" --help 2>&1 | head -20 || true
