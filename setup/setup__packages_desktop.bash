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
mkdir -p /home/$HOME_USER_NAME/.local/share/applications
sudo tee /home/$HOME_USER_NAME/.local/share/applications/chromium.desktop > /dev/null << 'EOF'
[Desktop Entry]
Version=1.0
Name=Chromium
GenericName=Web Browser
Exec=/usr/local/bin/chromium %U
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
EOF
chmod +x /home/$HOME_USER_NAME/.local/share/applications/chromium.desktop
xdg-settings set default-web-browser chromium.desktop
xdg-mime default chromium.desktop x-scheme-handler/http
xdg-mime default chromium.desktop x-scheme-handler/https
xdg-mime default chromium.desktop text/html

# dbeaver
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo tee /usr/local/bin/dbeaver > /dev/null << 'EOF'
#!/bin/bash
exec flatpak run io.dbeaver.DBeaverCommunity "$@"
EOF
sudo chmod +x /usr/local/bin/dbeaver

# zoom
sudo flatpak install -y flathub us.zoom.Zoom
sudo tee /usr/local/bin/zoom > /dev/null << 'EOF'
#!/bin/bash
exec flatpak run us.zoom.Zoom "$@"
EOF
sudo chmod +x /usr/local/bin/zoom
