#!/bin/bash

if grep -q "%HOME_USER_NAME%" $HOME/.config/i3/config; then
    echo "changed %HOME_USER_NAME% to $HOME_USER_NAME in .config/i3/config"
    sed -i "s/%HOME_USER_NAME%/$HOME_USER_NAME/" $HOME/.config/i3/config
fi

if grep -q "%HOME_SECOND_KEYBOARD_LAYOUT%" $HOME/.config/i3/config; then
    echo "changed %HOME_SECOND_KEYBOARD_LAYOUT% to $HOME_SECOND_KEYBOARD_LAYOUT in .config/i3/config"
    sed -i "s/%HOME_SECOND_KEYBOARD_LAYOUT%/$HOME_SECOND_KEYBOARD_LAYOUT/" $HOME/.config/i3/config
fi

cat <<EOF | sudo tee /etc/i3status.conf
general {
        colors = true
        interval = 5
}

order += "cpu_usage"
order += "load"
order += "disk /"
#order += "wireless _first_"
#order += "ethernet _first_"
#order += "battery all"
order += "volume master"
order += "tztime local"

wireless _first_ {
        format_up = "W: (%quality at %essid) %ip"
        format_down = "W: down"
}

ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

battery all {
        format = "%status %percentage %remaining"
}

tztime local {
        format = "%d.%m %H:%M"
}

load {
        format = "%1min"
}

disk "/" {
        format = "%avail"
}

volume master {
        format = "♪: %volume"
        format_muted = "♪: muted (%volume)"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
}

cpu_usage {
        format = "%usage"
}
EOF
