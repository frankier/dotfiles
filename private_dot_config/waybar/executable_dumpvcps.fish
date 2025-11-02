#!/bin/fish

./adjust.fish bright
ddcutil dumpvcp bright
./adjust.fish medium
ddcutil dumpvcp medium
./adjust.fish night
ddcutil dumpvcp night
