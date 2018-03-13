#!/bin/bash

echo Makding directory
mkdir -p /data/homebridge/

echo Copying files
cp /root/.homebridge/config.json /data/homebridge/

echo Starting homebridge
homebridge --user-storage-path /data/homebridge/
