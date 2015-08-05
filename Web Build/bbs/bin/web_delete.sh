#! /bin/bash
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin

. /opt/bbs/bin/common.sh

# ********** Set up internal variables
if [ -z "$1" ]; then
	err "No web name supplied."
	exit 1
else
	WEB_NAME=$1
fi
WEB_BUILD_FOLDER=/tmp/webbuild_${WEB_NAME}
WEB_FOLDER=/data/websites/dev/${WEB_NAME}

# *******************
# *  Main Work flow
# *******************
main_workflow(){

	# ********** Delete website
	msg "Deleting '${WEB_NAME}' website."
	rm -r /var/www/${WEB_NAME} >/dev/null 2>&1
	rm -r ${WEB_FOLDER} >/dev/null 2>&1

	# ********** Delete Database
	msg "Deleting web database"
	mysql -u root -pFlipper0 -e "DROP DATABASE IF EXISTS ${WEB_NAME};"
	
	# ********** Delete Email
	msg "Deleting Email"
}

main_workflow && exit 0 || exit 1