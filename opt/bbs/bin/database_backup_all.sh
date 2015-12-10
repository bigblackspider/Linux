#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Process input parameters
BACKUP_LOCATION=/data/websites/backup
if [ -z "$1" ]; then
	warn "Using default web backup location '${BACKUP_LOCATION}'."
else
	BACKUP_LOCATION=$1
fi
BACKUP_KEPT=10
if [ -z "$2" ]; then
	warn "Default number of backups kept = ${BACKUP_KEPT}."
else
	BACKUP_KEPT=$2
	msg "Number of backups kept = ${BACKUP_KEPT}."
fi

# ********** Set up variables
BACKUP_FILENAME=$(echo "${BACKUP_LOCATION}/all_db_$(date +"%Y%m%d_%H%M%S").zip"  | sed 's/-/_/g')
BACKUP_FILES_KEEP='1,10d'

# ********** Backing up databases
msg "Backing up all databases to file '${BACKUP_FILENAME}'."
mysqldump  --all-databases > /tmp/all.sql
zip ${BACKUP_FILENAME} /tmp/all.sql

# ********** Delete Old Backups
ls ${BACKUP_LOCATION}/all_db_*.zip -t | sed -e "1,"${BACKUP_KEPT}"d" | xargs -d '\n' rm 2>/dev/null

# ********** Final
msg "Done"
exit 0
