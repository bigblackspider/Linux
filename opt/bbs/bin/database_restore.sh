#! /bin/bash

# ********** Init
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin
. /opt/bbs/bin/common.sh

# ********** Process input parameters
if [ -z "$1" ]; then
        err "No database zip archive was selected."
        exit 1
else
        ZIP_ARCHIVE=$1
fi
if [ -z "$2" ]; then
        err "No database was selected."
        exit 1
else
        DATABASE_NAME=$2
fi

# ********** Restore Database
msg "Restoring database '${DATABASE_NAME}' from archive '${ZIP_ARCHIVE}'."
unzip -o -d / ${ZIP_ARCHIVE}
mysql -e "DROP DATABASE IF EXISTS ${DATABASE_NAME};"
mysql -e "CREATE DATABASE ${DATABASE_NAME};"
mysql ${DATABASE_NAME} < /tmp/${DATABASE_NAME}.sql

# ********** Final
msg "Done"
exit 0