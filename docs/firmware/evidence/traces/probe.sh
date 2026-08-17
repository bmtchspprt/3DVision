#!/usr/bin/env bash
set -u
echo "=== uname ==="
uname -a
echo "=== tools ==="
for t in gcc g++ make git flex bison makeinfo wget curl texinfo bfin-elf-run bfin-elf-gdb; do
  printf '%s: ' "$t"
  command -v "$t" || echo MISSING
done
echo "=== gcc version ==="
gcc --version 2>/dev/null | head -1
echo "=== apt available? ==="
command -v apt-get || echo NO-APT
echo "=== network ==="
if getent hosts sourceware.org >/dev/null 2>&1; then echo "dns-ok sourceware.org"; else echo "dns-fail"; fi
echo "=== cpu/mem ==="
nproc
free -h | head -2
echo "=== done ==="
