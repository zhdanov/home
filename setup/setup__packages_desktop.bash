#!/bin/bash

sudo apt-get -y install fbreader audacity growisofs peek screenkey cheese gimp obs-studio audacious unrar socat python3-gtts python3-pydub xdotool
sudo apt-get -y install goldendict brightnessctl


# chromium
sudo flatpak install -y flathub org.chromium.Chromium
sudo tee /usr/local/bin/chromium > /dev/null << 'EOF'
#!/bin/bash
exec flatpak run org.chromium.Chromium "$@"
EOF
sudo chmod +x /usr/local/bin/chromium

# dbeaver
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo tee /usr/local/bin/dbeaver > /dev/null << 'EOF'
#!/bin/bash
exec flatpak run io.dbeaver.DBeaverCommunity "$@"
EOF
sudo chmod +x /usr/local/bin/dbeaver

# dbeaver
sudo flatpak install -y flathub us.zoom.Zoom
sudo tee /usr/local/bin/zoom > /dev/null << 'EOF'
#!/bin/bash
exec flatpak run us.zoom.Zoom "$@"
EOF
sudo chmod +x /usr/local/bin/zoom
