#!/bin/bash

UPDATE=0
BETA=0
GITDIR="/data/data/com.termux/files/home/git"
HWLOCDIR="$GITDIR/hwloc"
XMRIGDIR="$GITDIR/xmrig"



help_screen() { 
        echo " "
        echo "AndroidXmrig-mo v0.3.0  (Burt Bacharach)"
        echo " "
        echo "Usage:"
        echo "      ./androidxmrig.sh [options]"
        echo " "
        echo "Options: "
        echo "          --update,    Update to the newsest stable release of xmrig-mo."
        echo "          --mo,        Update to the newest and untested xmrig-mo release from MoneroOcean."
        echo "          -h|--help,   This help screen."
        echo " "
        exit                

}

git_and_build_hwloc() {
        if [ ! -d "$GITDIR" ]; then
                mkdir "$GITDIR"
        fi
        
       cd "$GITDIR"
       git clone https://github.com/protomens/hwloc
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

        if [ ! -d "$GITDIR" ]; then
                mkdir "$GITDIR"
        fi
        
        cd "$GITDIR"
        
        if [ -d "$XMRIGDIR" ]; then
                rm -rf xmrig
        fi
        
        if [ ! -d "$HWLOCDIR" ]; then
                git_and_build_hwloc
        fi
        
        cd "$GITDIR"
      
        if [[ $BETA -eq 1 ]]; then          
                git clone https://github.com/MoneroOcean/xmrig
        else
                git clone https://github.com/SIEVEofEratosthenes/xmrig
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

        if [[ $BETA -eq 1 ]]; then          
                git clone https://github.com/MoneroOcean/xmrig
        else
                git clone https://github.com/SIEVEofEratosthenes/xmrig
        fi

        git clone https://github.com/zetakov/sieve-rig
        git_and_build_hwloc
        echo "Done"
        cd "$XMRIGDIR" && mkdir build && cd build
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
                --mo)
                        BETA=1
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


if [[ $UPDATE -eq 1 ]]; then
        update_xmrig
else
        fresh_install
fi


