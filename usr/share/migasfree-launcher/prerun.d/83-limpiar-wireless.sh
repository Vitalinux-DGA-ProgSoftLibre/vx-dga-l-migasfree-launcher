#!/bin/bash
if [ ${ENTCASA} = "TRUE" ] ; then
	echo "------------------------------------------"
	echo "--> Se van a eliminar los archivos de configuración Wireless innecesarios ..."
	INTERFAZ=$(iwconfig 2> /dev/null | tr -s " " " " | cut -d" " -f1 | grep -v ^" " | sed -e "/^$/d" | head -1)
	if ! test -z ${INTERFAZ} ; then
		MIRED=$(iwconfig 2> /dev/null | grep $INTERFAZ | awk -F'ESSID:' '{ print $2 }' | awk -F'"' '{ print $2 }')

		for ARCHIVO in $(grep -L $MIRED /etc/NetworkManager/system-connections/* | tr -s " " "*") ; do
			if  grep wireless "$(echo -n $ARCHIVO | tr -s '*' ' ')" &> /dev/null ; then
				if rm -rf "$(echo -n $ARCHIVO | tr -s '*' ' ')" ; then
					echo "--> Se ha eliminado $(echo -n $ARCHIVO | tr -s "*" " ") al no ser necesario ..."
				fi
			fi
		done
	fi
fi
