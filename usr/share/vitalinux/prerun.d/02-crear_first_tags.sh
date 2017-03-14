#!/bin/bash

#echo "Creando FIRST-TAGS ..."
if ! test -d /var/tmp/migasfree ; then
	echo "=> $(date) - No existe /var/tmp/migasfree: Creando FIRST-TAGS ..." >> ${LOGVX}
	mkdir -p /var/tmp/migasfree
	echo "" > /var/tmp/migasfree/first-tags.conf
	chmod 777 /var/tmp/migasfree
	chmod 666 /var/tmp/migasfree/first-tags.conf
else
	if test -z $(ls /var/tmp/migasfree) ; then
		echo "=> No existe first-tags.conf: Creando FIRST-TAGS ..." >> ${LOGVX}
		echo "" > /var/tmp/migasfree/first-tags.conf
		chmod 777 /var/tmp/migasfree
		chmod 666 /var/tmp/migasfree/first-tags.conf
	fi
fi
