#!/bin/bash

rm -rf out
mkdir out
FILES=*.pgm
for f in $FILES
do
mkdir out/$f
./main.m $f
mv *.pbm out/$f/
done
