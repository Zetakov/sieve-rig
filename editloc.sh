#!/bin/bash

if [[ $# -lt 2 ]]; then
	__usage="
	
		XMrig configuration MoneroOcean server editor v0.0.2

		Usage: $0 <file> <#>

		#:
			1:  gulf
			2:  us-va
			3:  us-or
	"
	echo "$__usage"
	exit
fi


FILE="$1"
NEWLOC=$2


LOC1="gulf.moneroocean.stream:20128"
LOC2="us-va.moneroocean.stream:20128"
LOC3="us-or.moneroocean.stream:20128"

if [[ $NEWLOC == "1" ]]; then
	sed -i 's/.*\"url\".*/\"url\": \"'"$LOC1"'\",/g' "$FILE"
elif [[ $NEWLOC == "2" ]]; then
	sed -i 's/.*\"url\".*/\"url\": \"'"$LOC2"'\",/g' "$FILE"

else
	sed -i 's/.*\"url\".*/\"url\": \"'"$LOC3"'\",/g' "$FILE"
	
fi


