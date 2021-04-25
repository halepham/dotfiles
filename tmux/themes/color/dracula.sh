#!/usr/bin/env bash

# palette
red="#ff5555"
green="#50fa7b"
yellow="#f1fa8c"
orange="#ffb86c"
blue="#6272a4"
purple="#bd93f9"
pink="#ff79c6"
cyan="#8be9fd"
foreground="#f8f8f2"
loadFg=$cyan        # load usage (for script)
windowBg="#21222c"  # black
statusBg="#282a36"  # bright black
blockBg="#44475a"   # brighter black

# left status
leftFore=$green
leftBack=$blockBg
prefixFlag=$cyan

# right status
rightFore=$purple
rightBack=$blockBg

# middle status
message=$foreground
statusBack=$statusBg
winActFore=$yellow
winActBack=$blockBg
syncFlag=$orange
winPasFore=$blue
winPasBack=$blockBg

# windows
windowBack=$windowBg
activePane=$blue
passivePane=$statusBg

# Copy mode
modeBack=$blockBg
modeFore=$purple

# Clock
clock=$purple

