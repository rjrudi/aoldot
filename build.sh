#!/bin/bash
#
# Jenkins build script
# Bob Rudi
# Nov 2015
######################

# Compile
cd app
go build server.go
BUILD_STATUS=$?
if [ $BUILD_STATUS -ne 0 ]; then
   echo "------ build failed ($BUILD_STATUS)"
   exit $BUILD_STATUS
fi
echo "------ build OK"
ls -l server.go server

# Test
./server 17122 &
sleep 5
REVISION=`curl -m 5 "http://localhost:17122" | grep -ci Revision 2>&1`
if [ -n $REVISION ] && [ $REVISION -gt 0 ]; then
   echo "------ build-test OK ($REVISION)"
   BUILD_STATUS=0
else
   echo "------ build-test failed ($REVISION)"
   BUILD_STATUS=1
fi
kill -9 %1
exit $BUILD_STATUS

