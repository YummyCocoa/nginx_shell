#!/bin/bash

# Nginx的日志存放地址
LOGS_FLODER=/www/wwwLogs
# Nginx拆分地址
LOGS_BACKUP_FLODER=/www/wwwLogs/History
# 获取昨天日期
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
# 获取上个月日期
LAST_MONTH=$(date -d "30 days ago" +%Y-%m-%d)
PID=/var/run/nginx.pid

for file in `ls ${LOGS_FLODER}`
do
  if [[ -f ${LOGS_FLODER}/${file} ]]
  then
    if [[ -s ${LOGS_FLODER}/${file} ]]
    then
      mv ${LOGS_FLODER}/${file} ${LOGS_BACKUP_FLODER}/${YESTERDAY}-${file}
      echo "备份文件${file}完成"
    fi
  fi
done

kill -USR1 $(cat ${PID})
