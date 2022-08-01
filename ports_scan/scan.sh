#!/bin/bash
#
# Example ./scan.sh <list_ip> <out_log>

IP_LIST=${1:-'ip_list.txt'}
printf -v TODAY 'scan_%(%F)T.txt' -1
OUTFILE=${2:-$TODAY}

function scan()
{
	host=$1
	printf '%s' "$host"
	
	for ((port=1;port<24;port++))
	do
		echo >/dev/null 2>&1 < /dev/tcp/${host}/${port}

		if (($? == 0))  ; then printf ' %d' "$port"  ; fi
	done
	echo
}

while read ip
do
    scan ${ip}
done < ${IP_LIST} > ${OUTFILE}