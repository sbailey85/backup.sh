#!/bin/bash

disk=$(df | grep vda | awk '{print $5}' | sed 's/%/ /g')
today=$(date -I)
path='/backup/'${today}
homedirs=$(ls -A /home)
MYSQLDUMP=$(which mysqldump)
MYSQL=$(which mysql)
DBDIR=${path}/dbs
mkdir -p $DBDIR
if [ $disk -gt '70' ] ; then
exit 1 ;


fi
mkdir /backup/$today

#mysqldump --all-databases | gzip -9 > $path/mysql.sql.gz

echo $path

for x in $homedirs ; do  tar czf /backup/$today/$x.tar.gz /home/$x ; done





DB=$(mysql -s -u root -e 'show databases;' | egrep -v '(Database|information_schema)')


for y in $DB ; do $MYSQLDUMP -u root --databases $DB | gzip > $DBDIR/$y.sql.gz  ; done
