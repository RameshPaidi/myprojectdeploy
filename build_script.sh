#!/bin/bash
set -e
ls && pwd
mkdir -p build
cd build
cmake ..
make -j8