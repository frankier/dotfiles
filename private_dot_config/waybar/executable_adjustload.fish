#!/bin/fish

cd (dirname (status -f))
ddcutil loadvcp $argv[1]
