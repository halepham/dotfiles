#!/usr/bin/env bash

dateOfWeek=$( date +"%a" )
case $dateOfWeek in
    "Mon")
        theme="duotone-sea";;
    "Tue")
        theme="duotone-space";;
    "Wed")
        theme="duotone-forest";;
    "Thu")
        theme="duotone-sky";;
    "Fri")
        theme="duotone-earth";;
    "Sat")
        theme="edge";;
    *)
        theme="paper";;
esac

time=$( date +"%0H%0M" )
if [ $time -le 0600 ] || [ $time -ge 1900 ]
then
    theme="dracula"
fi

colorPath="${HOME}/.tmux/themes/color/$theme.sh"
. "$colorPath"

##
# left side of the statusbar
prefix="#[fg=$leftBack,bg=#{?client_prefix,$prefixFlag,$leftFore},bold]"
sessionName=
leftStatus="$prefix #S #[bg=$statusBack]"

##
# Right side of the statusbar
lowlight="#[fg=$rightFore,bg=$rightBack,nobold]"
hightlight="#[fg=$rightBack,bg=$rightFore,bold]"
date="$lowlight %a %-d. %B %Y $hightlight %H:%M #[bg=$statusBack]"
memCpuLoad="#(~/.tmux/scripts/mem_cpu_load.sh $colorPath)"
changeTheme="#(~/.tmux/scripts/change_theme.sh)"
rightStatus="${memCpuLoad} ${date}${changeTheme}"

##
# Windows status
actHigh="#[fg=$winActBack,bg=$winActFore,nobold]"
pasHigh="#[fg=$winPasBack,bg=$winPasFore,nobold]"
actLow="#[fg=$winActFore,bg=#{?pane_synchronized,$syncFlag,$winActBack},nobold]"
pasLow="#[fg=$winPasFore,bg=$winPasBack,nobold]"
zoom="#{?window_zoomed_flag,[#I], #I }"
winActive="$actHigh$zoom$actLow #W " # active window
winPassive="$pasHigh #I $pasLow #W " # passive window

##
# Statusbar settings
tmux set-option -g window-active-style "bg=$windowBack"
tmux set-option -g window-style "bg=$windowBack"
tmux set-option -g pane-active-border-style "bg=$windowBack,fg=$activePane"
tmux set-option -g pane-border-style "bg=$windowBack,fg=$passivePane"
tmux set-option -g message-style "bg=$statusBack,fg=$message"
tmux set-option -g status-style "bg=$statusBack,fg=$message"

##
# print left side of the statusbar
tmux set-option -g status-left "$leftStatus" # sessionname

##
# print right side of the statusbar
tmux set-option -g status-right "$rightStatus" # date|time

##
# print windows status
tmux set-option -g window-status-separator " " # space between windows
tmux set-option -g window-status-current-format "$winActive" # active window
tmux set-option -g window-status-format "$winPassive" # passive windows

##
# Pane number display
tmux set-option -g display-panes-active-colour "$winActFore"
tmux set-option -g display-panes-colour "$winPasFore"

##
# Copy mode style
tmux set-option -g mode-style "bg=$modeBack,fg=$modeFore"

##
# Clock
tmux set-window-option -g clock-mode-colour "$clock"

#Bell
tmux set-window-option -g window-status-activity-style "bold"
tmux set-window-option -g window-status-bell-style "bold"
