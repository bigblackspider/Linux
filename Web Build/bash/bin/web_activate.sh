#! /bin/bash

# ********** Init
PATH=/sbin:/usr/sbin:/bin:/usr/bin
TEMPLATE_FOLDER=/data/templates/$1/src/
SQL_FOLDER=/data/templates/$1/sql/
WEB_FOLDER=/tmp/webbuild/$2/
TMP_FOLDER=/tmp/webbuild/$2/

echo "-----------------------------------------"
echo "Building '$2' website from template '$1'."

# ********** Build Web files
echo "Building Web Files"
mkdir -p ${WEB_FOLDER}
rm -r ${WEB_FOLDER}*
unzip ${TEMPLATE_FOLDER}web.zip -d ${WEB_FOLDER}
perl -pi -e "s/SITENAME/$2/g" ${WEB_FOLDER}configuration.php
sed -i "/log_path/c\    public \$log_path = '${WEB_FOLDER}logs';" ${WEB_FOLDER}configuration.php
sed -i "/tmp_path/c\    public \$tmp_path = '${WEB_FOLDER}tmp';" ${WEB_FOLDER}configuration.php
chown -R www-data:www-data ${WEB_FOLDER}

# ********** Build Database
echo "Building database"
mkdir -p ${TMP_FOLDER}
unzip ${SQL_FOLDER}web.zip -d ${TMP_FOLDER}
perl -pi -e "s/SITENAME/$2/g" ${TMP_FOLDER}web.sql
sed -i "s/SITE_TITLE/$3/" ${TMP_FOLDER}web.sql
sed -i "s/SITE_SLOGAN/$4/" ${TMP_FOLDER}web.sql
mysql -u root -pFlipper0 < ${TMP_FOLDER}web.sql

# ********** Add to Apache
echo "Add to Apache"
ln -s ${WEB_FOLDER} /var/www/$2
