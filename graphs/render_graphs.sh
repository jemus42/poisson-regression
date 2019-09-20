#! /usr/bin/env bash

for dotfile in $(ls *dot); do
  dot -Tpng -O $dotfile
done
