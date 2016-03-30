#!/bin/bash

containerID=$(docker run -d metaverseorg/buildnginx)
docker cp $containerID:/root/build/nginx-1.9.13/nginx_1.9.13-1_amd64.deb .
sleep 1
docker rm $containerID
