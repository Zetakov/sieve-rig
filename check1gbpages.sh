#!/bin/bash

coutput=`cat /proc/cpuinfo | egrep -o pdpe1gb`
onegbpages=$?
if [ $onegbpages == "0" ]; then
        echo "******************************************************"
        echo "*                                                    *"
        echo "*             Your CPU supports 1GB pages.           *"
        echo "*                                                    *"
        echo "******************************************************"
        echo " "
        echo "If XMRig is still saying it's unavailable, try the following: "
        echo " "
        echo "$ sudo nano /etc/default/grub"
        echo "Navigate to GRUB_CMDLINE_LINUX and append:"
        echo "default_hugepagesz=2M hugepagesz=1G hugepages=3"
        echo " "
        echo "$ update-grub"
        echo " "
        exit
else
        echo "Your CPU does not support 1GB pages. Sorry :*("
        echo " "
        exit
fi


