#!/usr/bin/env bash

### variables
#user=john
user=quentin
if [ "$user" = "john" ]
then
	repo=~/markov-decision
	path_to_package=/Users/john/.julia/v0.6/SnakeLadder
else
	repo=~/Documents/MA2Q2/Data_mining/markov-decision
	path_to_package=/home/quentin/.julia/v0.6/SnakeLadder
fi

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

