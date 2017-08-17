#!/usr/bin/env bash

TS=`echo $(date +"%Y-%m-%dT%H:%M:%SZ")`
echo "Dumping database starting at ${TS} ..."
cd ./db_dump
DNAME=${MYSQL_ENV_MYSQL_DATABASE}_$TS

start=`date +%s`
mysqldump -v \
	  --port=$MYSQL_PORT_3306_TCP_PORT \
	    --protocol=TCP \
	      --single-transaction \
	        -h $MYSQL_PORT_3306_TCP_ADDR \
		  -u $MYSQL_ENV_MYSQL_USER \
		    -p$MYSQL_ENV_MYSQL_PASSWORD \
		      $MYSQL_ENV_MYSQL_DATABASE > $DNAME.sql && gzip $DNAME.sql
end=`date +%s`
runtime=$((end-start))
echo "Done in ${runtime}s"
