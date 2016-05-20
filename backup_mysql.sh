#!/bin/bash



Date=`date +%Y%m%d`
Time=`date +%Y%m%d%H%M%S`
log=/scripts/log/log.txt
lck=/scripts/run.lck

echo “pgm start @” $Time >> $log

if [ -e $lck ];then
	echo “pgm still running, lock exists” >> $log
	exit 1

fi

touch $lck


BakDir=/mysqldata/
Fileprefix=mkt_prd_
DbHost=10.1.1.11
DbName=mkt_prd
Dbuser=db_mysql
Dbpass=db_mysql


cd $BakDir

DumpFile=$Fileprefix$Time.sql


/usr/bin/mysqldump -u$Dbuser -p$Dbpass -h$DbHost -B $DbName > $DumpFile

sleep  10m



if [ -s $DumpFile ] ;then

/usr/bin/mysql -u$Dbuser -p$Dbpass < $DumpFile

else
	echo "the file is error"   >> $log

fi




rm -f $lck

Time=`date +%Y%m%d%H%M%S`
echo “pgm ended @” $Time >> $log
