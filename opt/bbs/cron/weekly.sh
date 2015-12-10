#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Backup Databases
msg "Backing up databases"
database_backup_all.sh /data/websites/backup 52

# ********** Backup Sites
msg "Backing up sites"
folder_backup.sh websites_dev /data/websites/dev/ /data/websites/backup/ 52
folder_backup.sh websites_live /data/websites/live/ /data/websites/backup/ 52

# ********** Backup to S3
s3cmd sync /data/websites/backup/ --skip-existing --delete-removed --preserve s3://bbs-back/websites/

# ********** Final
exit 0
