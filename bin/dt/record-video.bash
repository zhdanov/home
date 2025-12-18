#/bin/bash

MONITOR_SOURCE=alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink.2.monitor

#FILE_NAME=30-habits-that-transformed-my-life.mp4
FILE_NAME=$1

# comment after first time
eval "$(slop -n -f 'W=%w H=%h X=%x Y=%y')" || { echo "Выделение отменено."; exit 1; }

[ -z "$W" ] && { echo "Пустые координаты — повторите выбор."; exit 1; }

# 3) Запуск ffmpeg с вашим monitor-источником
ffmpeg \
  -f x11grab -video_size "${W}x${H}" -framerate 30 -i "$DISPLAY+${X},${Y}" \
  -f pulse -thread_queue_size 1024 -i $MONITOR_SOURCE \
  -map 0:v:0 -map 1:a:0 \
  -filter:v "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p \
  -c:a aac -ar 48000 -ac 2 -b:a 160k \
  -movflags +faststart \
  $FILE_NAME
