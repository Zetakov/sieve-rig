#!/bin/bash

UPDATE=0
UPDATEALL=0
BETA=0
C3=0
GITDIR="/data/data/com.termux/files/home/git"
HWLOCDIR="$GITDIR/hwloc"
XMRIGDIR="$GITDIR/xmrig"



help_screen() { 
	__usage="

         AndroidXmrig-mo v0.5.1  (Maimonides)
         
         Usage:
               ./androidxmrig.sh [options]
          
         Options: 
                   --update,     Update to the newsest stable release of xmrig (pass --mo, --c3 as well for those versions of xmrig).
                   --update-all, Update to the newsest release of xmrig and its dependencies.
                   --mo,         Update (or install) to the newest and untested xmrig-mo release from MoneroOcean.
                   --c3,         Update (or install) the newest xmrig-C3 from C3pool.  
                   -h|--help,    This help screen.

	Note: Not passing any flags will download original xmrig and will be unable to algo-switch on MO.
	Please use --mo flag if you are using this on MoneroOcean or --c3 if you are on C3Pool.

        "  
	echo "$__usage"
        exit                

}

git_and_build_hwloc() {
        if [ ! -d "$GITDIR" ]; then
                mkdir "$GITDIR"
        fi
        
        if [ -d "$HWLOCDIR" ]; then
                rm -rf "$HWLOCDIR"
        fi
        
        cd "$GITDIR"
        git clone https://github.com/open-mpi/hwloc
        cd hwloc
        ./autogen.sh && ./configure &&  make

}

update_xmrig() {
        if [ -f "xmrig" ]; then
                echo "Removing old soft-link..."
                rm xmrig
                sleep 1
                echo "Done."
        fi
        echo "We need to change the termux repo. Select (Albatrosss) for best results on main repo"
        echo -ne "(Press enter to continue): "
        read blah
        sleep 1
        termux-change-repo
        apt-get full-upgrade -y
        apt-get -q -y install autoconf automake cmake git libtool binutils


        if [ ! -d "$GITDIR" ]; then
                mkdir "$GITDIR"
        fi
        
        cd "$GITDIR"
        
        if [ -d "$XMRIGDIR" ]; then
                rm -rf xmrig
        fi
        
        if [ ! -d "$HWLOCDIR" ] || [ $UPDATEALL -eq 1 ] ; then
                git_and_build_hwloc
        fi
        
        cd "$GITDIR"
      
        if [[ $BETA -eq 1 ]]; then          
                git clone https://github.com/MoneroOcean/xmrig
        elif [[ $C3 -eq 1 ]]; then
                git clone https://github.com/C3pool/xmrig-C3 xmrig
        else    
                git clone https://github.com/xmrig/xmrig
        fi
        
        cd "$XMRIGDIR" && mkdir build && cd build
        cmake .. -DHWLOC_INCLUDE_DIR=/data/data/com.termux/files/home/git/hwloc/include -DHWLOC_LIBRARY=/data/data/com.termux/files/home/git/hwloc/hwloc/.libs/libhwloc.so
        make
        echo "Done."
        
        cd /data/data/com.termux/files/home
        ln -s /data/data/com.termux/files/home/git/xmrig/build/xmrig xmrig
        echo "Run: nice ./xmrig -c <config_file>"
        
}


fresh_install() {
        echo "We need to change the termux repo. Select (Albatrosss) for best results on main repo"
        echo -ne "(Press enter to continue): "
        read blah
        sleep 1
        termux-change-repo
        echo " "
        echo -ne "Installing dependencies: (autoconf automake cmake git libtool)..."
        sleep 2
        apt-get full-upgrade -y
        apt-get -q -y install autoconf automake cmake git libtool binutils
        echo "Done."
        echo "Getting gits: (hwloc, xmrig, sieve-rig)..."
        mkdir git && cd git

        if [[ $BETA -eq 1 ]]; then          
                git clone https://github.com/MoneroOcean/xmrig
        elif [[ $C3 -eq 1 ]]; then
                git clone https://github.com/C3pool/xmrig-C3 xmrig
        else
                git clone https://github.com/xmrig/xmrig
        fi

        git clone https://github.com/zetakov/sieve-rig
        git_and_build_hwloc
        echo "Done"
        cd "$XMRIGDIR" && mkdir build && cd build
        cmake .. -DHWLOC_INCLUDE_DIR=/data/data/com.termux/files/home/git/hwloc/include -DHWLOC_LIBRARY=/data/data/com.termux/files/home/git/hwloc/hwloc/.libs/libhwloc.so
        make
        cp ../../sieve-rig/config.json .
        ln -s /data/data/com.termux/files/home/git/xmrig/build/xmrig xmrig
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
        echo "If all went as planned we will run xmrig-mo with benchmarking. If termux exits after benchmarking, either restart temux and xmrig or reboot the phone. This has to do with memory heaps being garbled during benchmarking."
        echo " "
        echo "Running xmrig and benchmarking...."
        sleep 6
        ./xmrig

}


while [ "$#" -gt 0 ]; do
        key=${1}

        case ${key} in
                --update)
                        UPDATE=1
                        shift
                        ;;
                --update-all)
                        UPDATEALL=1
                        shift
                        ;;
                --mo)
                        BETA=1
                        shift
                        ;;
                --c3)
                        C3=1
                        shift
                        ;;
                -h|--help)
                        help_screen
                        shift
                        ;;

                *)
                        shift
                        ;;
        esac
done


if [[ $UPDATE -eq 1 ]] || [[ $UPDATEALL -eq 1 ]]; then
        update_xmrig
else
        fresh_install
fi


