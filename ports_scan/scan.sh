#!/bin/bash

function scan()
{
	host=$1
	printf '%s' "$host"
	
	for ((port=1;port<1024;port++))
	do
		echo >/dev/null 2>&1 < /dev/tcp/${host}/${port}
		#printf "$?"
		if (($? == 0))  ; then printf ' %d' "$port"  ; fi
	done
	echo
}

#printf -v TODAY 'scan_%(%F)T' -1
printf -v TODAY 'scan_res' -1

OUTFILE=${1:-$TODAY}

#echo "$HOSTNAME"
#		echo >/dev/null 2>&1 < /dev/tcp/192.168.1.79/443

echo start

HOSTNAMES=78.155.219.50
HOSTNAMES=46.101.86.163

#echo "$(read HOSTNAME)"

#while read $HOSTNAMES
#do
	echo "$HOSTNAMES"
	scan $HOSTNAMES > $OUTFILE
#done #> $OUTFILE