#!/bin/bash

if [ $# -lt 3 ]; then
        echo " "
        echo "Edit XMRig config v1.0"
        echo " "
        echo "Usage: $0 <MoneroAddress> <WorkerName> <config.json>"
        echo " "
        echo "Use quotes for <WorkerName> if it contains spaces"
        exit
fi

MOADDY=$1
WORKER=$2
CONFIGFILE=$3

sed -i 's/"url": *"[^"]*",/"url": "gulf.moneroocean.stream:10032",/' ./$CONFIGFILE
sed -i 's/"user": *"[^"]*",/"user": "'$MOADDY'",/' ./$CONFIGFILE
sed -i 's/"pass": *"[^"]*",/"pass": "'"$WORKER"'",/' ./$CONFIGFILE

#sed -i 's/"huge-pages": true,/"huge-pages": false,/' ./config.json
