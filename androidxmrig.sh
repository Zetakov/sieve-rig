#!/bin/bash

rm xmrig
echo "We need to change the termux repo. Select (grimler) for best results on main repo"
echo -ne "(Press enter to continue): "
read blah
sleep 1
termux-change-repo
echo " "
echo -ne "Installing dependencies: (autoconf automake cmake git libtool)..."
sleep 2
apt-get -q -y install autoconf automake cmake git libtool 
echo "Done."
echo "Getting gits: (hwloc, xmrig, sieve-rig)..."
mkdir git && cd git
git clone https://github.com/protomens/hwloc
git clone https://github.com/protomens/xmrig
git clone https://github.com/zetakov/sieve-rig
echo "Done"
cd hwloc
./autogen.sh && ./configure &&  make
cd .. && cd xmrig && mkdir build && cd build
cmake .. -DHWLOC_INCLUDE_DIR=/data/data/com.termux/files/home/git/hwloc/include -DHWLOC_LIBRARY=/data/data/com.termux/files/home/git/hwloc/hwloc/.libs/libhwloc.so
make
cp ../../sieve-rig/config.json .
sed -i 's/"url": *"[^"]*",/"url": "gulf.moneroocean.stream:20032",/' ./config.json
echo -ne "XMR Address: "
read XMRADDRESS
sed -i 's/"user": *"[^"]*",/"user": "'$XMRADDRESS'",/' ./config.json
echo -ne "Worker Name: "
read WORKER
sed -i 's/"pass": *"[^"]*",/"pass": "'"$WORKER"'",/' ./config.json
sed -i 's/"tls": false,/"tls": true,/' ./config.json
sed '/"tls":.*$/{n;s/false/true/}' -i ./config.json
sed -i 's/"mode": *"[^"]*",/"mode": "lite",/' ./config.json
cd /data/data/com.termux/files/home
ln -s git/xmrig/build/xmrig xmrig
echo "If all went as planned we will run xmrig-mo with benchmarking. If termux exits after benchmarking, either restart temux and xmrig or reboot the phone. This has to do with memory heaps being garbled during benchmarking."
echo " "
echo "Running xmrig...."
sleep 4
./xmrig

