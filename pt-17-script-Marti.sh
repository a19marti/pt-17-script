#!/bin/bash

usage(){
cat <<EOF	
	exemple: $0 -u nom_usuari -h direccio_host [-p port ] [-t]
EOF
}
while getopts ":u:h:p:t" o; do
	case "${o}" in
	u)
		USUARI=$OPTARG
		;;
	h)
		HOST=$OPTARG
		;;
	p)
		PORT=$OPTARG
		if [ $PORT -lt 1024 ] || [ $PORT -gt 65535 ];then
			echo "ERROR: El port ha de ser mes gran de 1024 i menor o igual a 65535" 1>&2
			usage
		fi
		;;
	t)
		TEST=1
		;;
	:)
		echo "ERROR: Opció -$OPTARG requereix un argument" 1>&2
		usage
		;;
	\?)
		echo "ERROR: Opció invalida -$OPTARG" 1>&2
		usage
		;;
	esac
done

if [ -z $USUARI ]; then
	echo "ERROR: L'opció -u és obligatoria" 1>&2
	usage
fi
if [ -z $HOST ]; then
	echo "ERROR: L'opció -h és obligatoria" 1>&2
	usage
fi
echo "USUARI: "$USUARI
echo "HOST: "$HOST
if [ -z $PORT ];then
	echo "PORT: 3306"
else
	echo "PORT: "$PORT
fi
if [ -z $TEST ];then
	echo "TEST: FALSE"
else
	echo "TEST: TRUE"
fi