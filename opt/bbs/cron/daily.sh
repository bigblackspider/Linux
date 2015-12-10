#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Backup Databases
msg "Backing up databases"
database_backup.sh familykarate_dev
database_backup.sh crystalwellbeing_dev
database_backup.sh rwhittleflooring_dev

database_backup.sh familykarate_live
database_backup.sh crystalwellbeing_live
database_backup.sh rwhittleflooring_live

# ********** Backup Sites
msg "Backing up sites"
folder_backup.sh bbs_dev /data/websites/dev/bbs/
folder_backup.sh familykarate_dev /data/websites/dev/familykarate/
folder_backup.sh crystalwellbeing_dev /data/websites/dev/crystalwellbeing/
folder_backup.sh rwhittleflooring_dev /data/websites/dev/rwhittleflooring/

folder_backup.sh bbs_live /data/websites/live/bbs/
folder_backup.sh familykarate_live /data/websites/live/familykarate/
folder_backup.sh crystalwellbeing_live /data/websites/live/crystalwellbeing/
folder_backup.sh rwhittleflooring_live /data/websites/live/rwhittleflooring/

# ********** Final
exit 0
