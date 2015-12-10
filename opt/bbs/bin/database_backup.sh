#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Process input parameters
if [ -z "$1" ]; then
        err "No database was selected."
        exit 1
else
        DATABASE_NAME=$1
fi
BACKUP_LOCATION=/data/websites/backup
if [ -z "$2" ]; then
	warn "Using default web backup location '${BACKUP_LOCATION}'."
else
	BACKUP_LOCATION=$2
fi
BACKUP_KEPT=10
if [ -z "$2" ]; then
	warn "Default number of backups kept = ${BACKUP_KEPT}."
else
	BACKUP_KEPT=$2
	msg "Number of backups kept = ${BACKUP_KEPT}."
fi

# ********** Set up variables
BACKUP_FILENAME=$(echo "${BACKUP_LOCATION}/${DATABASE_NAME}_db_$(date +"%Y%m%d_%H%M%S").zip"  | sed 's/-/_/g')

# ********** Backing up database
msg "Backing up database '${DATABASE_NAME}' to file '${BACKUP_FILENAME}'."
mysqldump ${DATABASE_NAME} > /tmp/${DATABASE_NAME}.sql
zip ${BACKUP_FILENAME} /tmp/${DATABASE_NAME}.sql

# ********** Delete Old Backups
ls ${BACKUP_LOCATION}/${DATABASE_NAME}_db_*.zip -t | sed -e "1,"${BACKUP_KEPT}"d" | xargs -d '\n' rm 2>/dev/null

# ********** Final
msg "Done"
exit 0

