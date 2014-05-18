#!/bin/bash
DATE=`date +%Y_%m_%d`
echo $DATE
#sudo drush sql-dump > /var/www/blog.lequerec.fr/database/seb.sql
#sudo tar -zcf ./seblog.tar.gz /var/www/blog.lequerec.fr
LISTEBDD=$( echo 'show databases' | mysql -u root --password=yourpass )
echo $LISTEBDD
for SQL in $LISTEBDD
do
if [ $SQL != "information_schema" ] && [ $SQL != "mysql" ] && [ $SQL != "Database" ] && [ $SQL != "performance_schema" ]; then
echo $SQL
mysqldump -root --password=yourpass $SQL | gzip > ./$SQL"_mysql_"$DATE.sql.gz
fi
done

 