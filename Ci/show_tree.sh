#!/bin/sh

shopt -s globstar
for rdir in ./
do
    for file in $rdir/**
    do
      echo "$file"
    done
done
