#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
  build-essential \
  gcc g++ make \
  wget ca-certificates xz-utils \
  texinfo \
  libgmp-dev libmpfr-dev libmpc-dev \
  zlib1g-dev libncurses-dev \
  flex bison \
  python3
echo "=== deps done ==="
gcc --version | head -1
ldconfig -p | grep -E 'libgmp|libmpfr' | head -3 || true
