#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Process input parameters
if [ -z "$1" ]; then
        err "No backup name was entered."
        exit 1
else
        BACKUP_NAME=$1
fi
if [ -z "$2" ]; then
        err "No source folder was entered."
        exit 1
else
        SOURCE_FOLDER=$2
fi
BACKUP_LOCATION=/data/websites/backup
if [ -z "$3" ]; then
	warn "Using default web backup location '${BACKUP_LOCATION}'."
else
	BACKUP_LOCATION=$3
fi
BACKUP_KEPT=10
if [ -z "$4" ]; then
	warn "Default number of backups kept = ${BACKUP_KEPT}."
else
	BACKUP_KEPT=$4
	msg "Number of backups kept = ${BACKUP_KEPT}."
fi

# ********** Set up variables
BACKUP_FILENAME=$(echo "${BACKUP_LOCATION}/${BACKUP_NAME}_folder_$(date +"%Y%m%d_%H%M%S").zip"  | sed 's/-/_/g')
BACKUP_FILES_KEEP='1,10d'

# ********** Backing up folder
msg "Backing up folder '${SOURCE_FOLDER}' to file '${BACKUP_FILENAME}'."
zip -r ${BACKUP_FILENAME} ${SOURCE_FOLDER}

# ********** Delete Old Backups
ls ${BACKUP_LOCATION}/${BACKUP_NAME}_folder_*.zip -t | sed -e "1,"${BACKUP_KEPT}"d" | xargs -d '\n' rm 2>/dev/null

# ********** Final
msg "Done"
exit 0

