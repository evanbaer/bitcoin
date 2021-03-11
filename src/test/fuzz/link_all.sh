#!/usr/bin/env bash
# Copyright (c) 2020 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C.UTF-8

set -e

ROOT_DIR="$(git rev-parse --show-toplevel)"

# Run only once (break make recursion)
if [ -d "${ROOT_DIR}/lock_fuzz_link_all" ]; then
  exit
fi
mkdir "${ROOT_DIR}/lock_fuzz_link_all"

echo "Symlinking each fuzz target separately."
for FUZZING_HARNESS in $(PRINT_ALL_FUZZ_TARGETS_AND_ABORT=1 "${ROOT_DIR}/src/test/fuzz/fuzz" | sort -u); do
    rm -f "${ROOT_DIR}/src/test/fuzz/${FUZZING_HARNESS}"
    ln -s "fuzz" "${ROOT_DIR}/src/test/fuzz/${FUZZING_HARNESS}"
done
echo "Successfully symlinked all fuzz targets."
