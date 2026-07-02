#!/bin/bash

source $1

# CPU
function get_cpu_usage() {
    grep "$1" /proc/stat |\
    awk '{idle=($5+$6);total=($2+$3+$4+$5+$6+$7+$8+$9);\
          printf idle " " total}'
}
function cpu() {
    # Get prevous CPU usage
    pre=( $( get_cpu_usage "$1" ) )

    sleep 1
 
    # Get current CPU usage
    cur=( $( get_cpu_usage "$1" ) )

    # Calculating CPU usage percentage
    let idle=cur[0]-pre[0]
    let total=cur[1]-pre[1]
    cpu_usage=$( echo "scale=1;($total - $idle) * 100 / $total" | bc )
    echo $cpu_usage
}

function cpu_graph() {
    usage=$( cpu 'cpu ')
    reset_color="#[fg=$foreground, nobold]"
    if (( $( echo "$usage < 20" | bc ) )); then
        color="#[fg=$green, nobold]" # green
    elif (( $( echo "$usage < 50" | bc ) )); then
        color="#[fg=$yellow, nobold]" # yellow
    elif (( $( echo "$usage < 80" | bc ) )); then
        color="#[fg=$orange, nobold]" # orange
    else
        color="#[fg=$red, nobold]" # red
    fi

    # Display CPU
    num=$( echo "$usage / 10" | bc )
    graph="${reset_color}[${color}"
    for i in {1..10}; do
        if [[ $i -le $num ]]; then
            graph+="|"
        else
            graph+=" "
        fi
    done
    graph+="${reset_color}]${color}"
    printf '%s%5.1f%%%s' "${graph}" "$usage" "${reset_color}"
}

# Memmory
function memmory() {
    mem_total=$( cat /proc/meminfo | grep '^MemTotal:' | grep -oP '[0-9]+' )
    mem_free=$( cat /proc/meminfo | grep '^MemFree:' | grep -oP '[0-9]+' )
    buffers=$( cat /proc/meminfo | grep '^Buffers:' | grep -oP '[0-9]+' )
    cached=$( cat /proc/meminfo | grep '^Cached:' | grep -oP '[0-9]+' )
    swap_cached=$( cat /proc/meminfo | grep '^SwapCached:' | grep -oP '[0-9]+' )

    # Calculating memmory used
    mem_used=$( echo "$mem_total - $mem_free" | bc )
    mem_used=$( echo "$mem_used - $buffers - $cached - $swap_cached" | bc ) 

    # Convert to MB
    mem_total=$( echo "$mem_total/1024" | bc )
    mem_used=$( echo "$mem_used/1024" | bc )

    # Display memmory
    reset_color="#[fg=$foreground, nobold]"
    if (( $( echo "$mem_used * 100 /$mem_total < 20" | bc ) )); then
        color="#[fg=$green, nobold]" # green
    elif (( $( echo "$mem_used * 100 /$mem_total < 50" | bc ) )); then
        color="#[fg=$yellow, nobold]" # yellow
    elif (( $( echo "$mem_used * 100 /$mem_total < 80" | bc ) )); then
        color="#[fg=$orange, nobold]" # orange
    else
        color="#[fg=$red, nobold]" # red
    fi
    echo "${color}$mem_used${reset_color}/${color}$mem_total${reset_color}MB"
}

# Load average
function load_average()
{
    load=$( uptime | grep -oP '(?<=average: )[0-9., ]+' | sed 's/, / /g' )
    echo "#[fg=$loadFg, nobold]$load"
}

printf ' %s %s %s' "$(memmory)" "$(cpu_graph)" "$(load_average)"
