#!/bin/bash

sudo sed -i -e '/^.*\/bin\/backup\-to\-cloud\.bash$/d' /etc/crontab
echo "$HOME_BACKUP_CRON root /bin/bash $HOME/bin/backup-to-cloud.bash" | sudo tee -a /etc/crontab

sudo systemctl restart cron
