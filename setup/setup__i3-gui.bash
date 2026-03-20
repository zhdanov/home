#!/bin/bash

sudo apt-get -y install \
i3 i3status \
rofi arandr thunar xarchiver ttf-mscorefonts-installer kate pasystray samba gitk maim mpv pulseaudio pavucontrol

# alacritty
sudo apt-get -y install alacritty ntfs-3g exfatprogs
sudo tee /usr/bin/i3-sensible-terminal > /dev/null << 'EOF'
#!/bin/bash
exec alacritty "$@"
EOF
sudo chmod +x /usr/bin/i3-sensible-terminal
