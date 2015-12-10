#! /bin/bash

. /opt/bbs/bin/common.sh

# ********** Process input parameters
if [ -z "$1" ]; then
	warn "No Template specified using default."
	WEB_TEMPLATE=default
else
	WEB_TEMPLATE=$1
fi
if [ -z "$2" ]; then
	warn "No web name specified using test."
	WEB_NAME=test
else
	WEB_NAME=$2
fi

msg "Building Joomla website '${WEB_NAME}' using template '${WEB_TEMPLATE}'."

# ********** Set up variables
TEMPLATE_FOLDER=/opt/bbs/webbuild/templates/$WEB_TEMPLATE/src
SQL_FOLDER=/opt/bbs/webbuild/templates/$WEB_TEMPLATE/sql
WEB_FOLDER=/data/websites/build/$WEB_NAME
TMP_FOLDER=/tmp/webbuild_$WEB_NAME

# ********** Build Web files
msg "Building Web."
mkdir -p ${WEB_FOLDER}
rm -r ${WEB_FOLDER}*
unzip ${TEMPLATE_FOLDER}/web.zip -d ${WEB_FOLDER}
perl -pi -e "s/SITENAME/$2/g" ${WEB_FOLDER}/configuration.php
sed -i "/log_path/c\    public \$log_path = '${WEB_FOLDER}logs';" ${WEB_FOLDER}/configuration.php
sed -i "/tmp_path/c\    public \$tmp_path = '${WEB_FOLDER}tmp';" ${WEB_FOLDER}/configuration.php
chown -R www-data:www-data ${WEB_FOLDER}

# ********** Build Database
msg "Building database"
mkdir -p ${TMP_FOLDER}
unzip ${SQL_FOLDER}/web.zip -d ${TMP_FOLDER}
perl -pi -e "s/SITENAME/$WEB_NAME/g" ${TMP_FOLDER}/web.sql
sed -i "s/SITE_TITLE/$3/" ${TMP_FOLDER}/web.sql
sed -i "s/SITE_SLOGAN/$4/" ${TMP_FOLDER}/web.sql
mysql -u root -pFlipper0 < ${TMP_FOLDER}/web.sql

# ********** Add to Apache
msg "Activating website"
ln -s ${WEB_FOLDER} /var/www/$WEB_NAME