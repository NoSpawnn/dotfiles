#!/usr/bin/env bash

# battery
readonly BAT=/sys/class/power_supply/BAT0
if [[ -r "$BAT/status" && -r "$BAT/capacity" ]]; then
    capacity=$(<"$BAT/capacity")
    status=$(<"$BAT/status")
    case "$status" in
        Discharging) battery_status=" BAT: ${capacity}%" ;;
        Charging)    battery_status=" BAT: ${capacity}% (CHRG)" ;;
        Full)        battery_status=" BAT: ${capacity}% (full)" ;;
        *)           battery_status=" BAT: ${capacity}% ($status)" ;;
    esac
    battery_status+=" |"
else
    battery_status=""
fi

# network
if nmcli -t -f STATE general | grep -qx connected; then
    network_status="NET: connected |"
else
    network_status="NET: offline |"
fi

# result
echo "$network_status$battery_status $(date '+%d/%m/%Y %H:%M:%S')"
