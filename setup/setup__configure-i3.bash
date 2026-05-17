#!/bin/bash

if grep -q "%HOME_USER_NAME%" $HOME/.config/i3/config; then
    echo "changed %HOME_USER_NAME% to $HOME_USER_NAME in .config/i3/config"
    sed -i "s/%HOME_USER_NAME%/$HOME_USER_NAME/" $HOME/.config/i3/config
fi

if grep -q "%HOME_SECOND_KEYBOARD_LAYOUT%" $HOME/.config/i3/config; then
    echo "changed %HOME_SECOND_KEYBOARD_LAYOUT% to $HOME_SECOND_KEYBOARD_LAYOUT in .config/i3/config"
    sed -i "s/%HOME_SECOND_KEYBOARD_LAYOUT%/$HOME_SECOND_KEYBOARD_LAYOUT/" $HOME/.config/i3/config
fi

if grep -q "%HOME_THIRD_KEYBOARD_LAYOUT%" $HOME/.config/i3/config; then
    echo "changed %HOME_THIRD_KEYBOARD_LAYOUT% to $HOME_THIRD_KEYBOARD_LAYOUT in .config/i3/config"
    sed -i "s/%HOME_THIRD_KEYBOARD_LAYOUT%/$HOME_THIRD_KEYBOARD_LAYOUT/" $HOME/.config/i3/config
fi

if ! grep video /etc/group | grep -q $USER; then
    sudo usermod -aG video $USER
fi

cat <<EOF | sudo tee /etc/i3status.conf
general {
        colors = true
        interval = 10
}

order += "battery all"
order += "volume master"
order += "load"
order += "cpu_usage"
order += "memory"
order += "disk /"
order += "tztime local"
#order += "wireless _first_"
#order += "ethernet _first_"

memory {
    format= "FREE RAM/HDD %available"
    threshold_degraded = "300M"
    format_degraded = "FREE RAM/HDD %available"
}

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
        format = "| %A %d.%m.%Y %H:%M"
}

load {
        format = "CPU %1min"
}

disk "/" {
        format = "%avail"
}

volume master {
        format = "VOL %volume"
        format_muted = "muted (%volume)"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
}

cpu_usage {
        format = "%usage"
}
EOF
