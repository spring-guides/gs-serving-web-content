#!/bin/bash
STATUS=`curl -s -o /dev/null -w "%{http_code}" http://34.234.85.118:8181`
if [ ${STATUS} == 200 ]
then 
echo " APPLICATION IS UP AND RUNNING"
else
echo " APPLICATION IS DOWN "
exit 1
fi

