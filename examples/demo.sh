#!/usr/bin/env sh
set -eu
cc -std=c99 -Wall -Wextra -O2 ../lim.c -o lim
./lim -r rules.lim --summary < sample.tlm
