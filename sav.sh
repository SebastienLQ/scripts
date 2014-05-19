#!/bin/bash
DATE=`date +%Y_%m_%d`
echo $DATE
#sudo drush sql-dump > /var/www/blog.lequerec.fr/database/seb.sql
#sudo tar -zcf ./seblog.tar.gz /var/www/blog.lequerec.fr

echo "Entrez le repertoire de sauvegarde :"
read dir
mkdir $dir
echo "Entrez votre login mysql:"
stty -echo
read login
stty echo
echo "Entrez votre mot de passe mysql:"
stty -echo
read passe
stty echo
LISTEBDD=$( echo 'show databases' | mysql -u $login --password=$passe )
echo $LISTEBDD
for SQL in $LISTEBDD
do
if [ $SQL != "information_schema" ] && [ $SQL != "mysql" ] && [ $SQL != "Database" ] && [ $SQL != "performance_schema" ]; then
echo $SQL
mysqldump -$login --password=$passe $SQL | gzip > $dir/$DATE"_mysql_"$SQL.sql.gz
fi
done

 