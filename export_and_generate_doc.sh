#!/usr/bin/env bash

### variables
repo=~/markov-decision
user=john
#user=quentin
path_to_package=/Users/$user/.julia/v0.6/SnakeLadder


### code part
# src
cp -rf $repo/code/src/* $path_to_package/src/;
# test
cp -rf $repo/code/test/* $path_to_package/test/;

### doc part 
# copy docs to real package doc
cp -rf $repo/code/docs/* $path_to_package/docs/;
# execute make.jl
julia $path_to_package/docs/make.jl;
# copy back doc to repo
cp -rf $path_to_package/docs/build/* $repo/html_doc/

