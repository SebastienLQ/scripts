#!/bin/bash
DATE=`date +%Y_%m_%d`
echo "Entrer le repertoires des sites : "
read sitedir
echo "Entrez le repertoire de sauvegarde :"
read dir
mkdir $dir
echo "Entrez votre login mysql:"
read login
echo "Entrez votre mot de passe mysql:"
stty -echo
read passe
stty echo
LISTEBDD=$( echo 'show databases' | mysql -u $login --password=$passe )
echo $LISTEBDD
for SQL in $LISTEBDD
do
if [ $SQL != "information_schema" ] && [ $SQL != "mysql" ] && [ $SQL != "Database" ] && [ $SQL != "performance_schema" ]; then
echo -e "Compression de :"$SQL"\tvers :\t"$dir/$DATE"_mysql_"$SQL.sql.gz
mysqldump -$login --password=$passe $SQL | gzip > $dir/$DATE"_mysql_"$SQL.sql.gz
fi
done
LISTSITE="$(find $sitedir/* -type d -prune | awk -F"/" '{print $NF}')"
echo $LISTSITE
for SITE in $LISTSITE; 
do 
echo -e "Compression de : "$SITE"\tvers :\t"$dir/$DATE-$SITE".tar.gz"
tar -zcf $dir/$DATE-$SITE.tar.gz $SITE
done
 