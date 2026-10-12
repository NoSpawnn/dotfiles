#!/usr/bin/env bash

date_formatted=$(date "+%F %H:%M:%S")
battery_status="BAT: $(cat /sys/class/power_supply/BAT0/capacity)%"

echo "$battery_status | $date_formatted"
