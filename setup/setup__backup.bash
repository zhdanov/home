#!/bin/bash

sudo sed -i -e '/^.*\/bin\/backup\.bash$/d' /etc/crontab
echo "$HOME_BACKUP_CRON root /bin/bash $HOME/bin/backup.bash" | sudo tee -a /etc/crontab
