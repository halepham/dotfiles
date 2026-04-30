#!/bin/bash

source $1

DIR="/sys/class/power_supply/BAT0"
charge_full=$( cat $DIR/charge_full )
charge_now=$( cat $DIR/charge_now )
current_now=$( cat $DIR/current_now )
batt_status=$( cat $DIR/status )

function battery_life() {
    batt_per=$( echo "scale=1;$charge_now * 100 / $charge_full" | bc )
    reset_color="#[fg=$fg, bg=$bg, nobold]"
    if (( $( echo "$batt_per > 80" | bc ) )); then
        color="#[fg=$green, bg=$bg, nobold]" # green
    elif (( $( echo "$batt_per > 40" | bc ) )); then
        color="#[fg=$yellow, bg=$bg, nobold]" # yellow
    elif (( $( echo "$batt_per > 20" | bc ) )); then
        color="#[fg=$orange, bg=$bg, nobold]" # orange
    else
        color="#[fg=$red, bg=$bg, nobold]" # red
    fi

    # Display battery life
    num=$( echo "$batt_per / 20" | bc )
    graph="${reset_color}[${color}"
    for i in {1..5}; do
        if [[ $i -le $num ]]; then
            graph+="|"
        else
            graph+=" "
        fi
    done
    graph+="${reset_color}]${color}"
    printf '%s %4.1f%%%s' "${graph}" "$batt_per" "${reset_color}"
}

function convert_time() {
    batt_time=$1
    sec=$( echo "$batt_time % 60" | bc )
    min=$( echo "$batt_time / 60 % 60" | bc )
    hour=$( echo "$batt_time / 3600" | bc )

    if [[ $hour -gt 0 ]]; then
        printf '%d:%02d left' "$hour" "$min"
    elif [[ $min -gt 0 ]]; then
        printf '%d mins left' "$min"
    else
        printf '<1 min left'
    fi
}

function battery_time() {
    if [[ $current_now -gt 1000 ]]; then
        if [[ $batt_status == "Charging" ]]; then
            batt_time=$(echo "($charge_full-$charge_now)*3600/$current_now"| bc)
        elif [[ $batt_status == "Discharging" ]]; then
            batt_time=$( echo "$charge_now * 3600 / $current_now"| bc )
        fi
        printf "$batt_status $( convert_time $batt_time )"
    else
        batt_life=$(battery_life)
        if [[ $batt_life -eq 100 ]]; then
            batt_status="Fully-charged"
        else
            batt_status="Estimating..."
        fi
        printf "$batt_status"
    fi

}

printf '%s %s ' "$(battery_life)" "$(battery_time)"
