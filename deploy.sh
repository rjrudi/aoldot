#!/bin/bash
#
# Jenkins deploy script
# Bob Rudi
# Nov 2015
#######################

# Get running PID and kill it
PID=`ps -fu $USER | grep -v grep | grep server | awk '{print $2}'`
if [ -n "$PID" ]; then
   kill -9 $PID
   sleep 1
fi

# Launch (chaning the BUILD_ID prevents Jenkins from killing the nohup'd server)
cd app
export BUILD_ID=12345678
nohup ./server 8888 > nohup.log 2>&1 &
sleep 5
REVISION=`curl --silent -m 5 "http://localhost:8888" | grep -ci Revision 2>&1`
if [ -n $REVISION ] && [ $REVISION -gt 0 ]; then
   echo "------ deploy OK ($REVISION)"
   DEPLOY_STATUS=0
else
   echo "------ deploy failed ($REVISION)"
   DEPLOY_STATUS=1
fi

# Copy binary to S3
if [ $DEPLOY_STATUS -eq 0 ]; then
   aws s3 cp server s3://aoldot/server
   DEPLOY_STATUS=$?
fi
   
exit $DEPLOY_STATUS


