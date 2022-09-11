#!/bin/bash
container=`docker ps | grep "sample-service" | awk -F " " '{print $NF}'`
if [ -z "$container" ]
then
  echo "No container found"
else
  echo "Cleaning previous deployments"
  docker rm test-nodejs -f
  image=`docker ps | grep "sample-service" | awk -F " " '{print $2}'`
  docker rmi $image
fi
echo "Done"
