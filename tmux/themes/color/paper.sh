#!/usr/bin/env bash

# palette
red="colour160"
green="colour148"
yellow="colour214"
orange="colour208"
blue="colour037"
purple="colour205"
pink="colour199"
cyan="colour050"
foreground="colour255"
loadFg=$blue          # load usage (for script)
windowBg="colour234"  # black
statusBg="colour235"  # bright black
blockBg="colour237"   # brighter black

# left status
leftFore=$blue
leftBack=$blockBg
prefixFlag=$orange

# right status
rightFore=$yellow
rightBack=$blockBg

# middle status
message=$foreground
statusBack=$statusBg
winActFore=$green
winActBack=$blockBg
syncFlag=$purple
winPasFore=$blue
winPasBack=$blockBg

# windows
windowBack=$windowBg
activePane=$green
passivePane=$blue

# Copy mode
modeBack=$blockBg
modeFore=$yellow

# Clock
clock=$purple

