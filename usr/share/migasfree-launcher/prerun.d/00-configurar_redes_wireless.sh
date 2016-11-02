#!/bin/bash
# Configuramos la Wireless para las redes que haya por defeto en /opt/pkgs/wireless

if [ -f $_FIRST ] ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
  #if test -z $FIRSTWIRELESS ; then
  ## Comprobamos si hay alguna interfaz wireless en el equipo para configurar las redes wireless por defecto
  ##if sudo lshw -C network | grep "inalámbrica" &> /dev/null || sudo lshw -C network | grep "[Ww]ireless" &> /dev/null ; then
	# Comprobamos si hay una interfaz wireless en el equipo y configuramos las redes
	INTERFAZ=$(iwconfig 2> /dev/null | tr -s " " " " | cut -d" " -f1 | grep -v ^" " | sed -e "/^$/d" | head -1)
	if test "$INTERFAZ" != "" ; then
		MIMAC=$(ifconfig ${INTERFAZ} | head -1 | tr -s " " " " | cut -d" " -f5)
		echo "--> Se ha detectado al menos una interfaz Wireless: $INTERFAZ - $MIMAC ..."
		echo "--> Se va ha configurar las redes Wireless disponibles de Centros Vitalinux ..."
		if test -d /usr/share/vitalinux/wireless ; then
			chmod 755 /usr/share/vitalinux/wireless
			chmod -R 600 /usr/share/vitalinux/wireless/*
			rsync -ahv --chown=root:root --chmod=600 \
				--ignore-existing \
				/usr/share/vitalinux/wireless/* /etc/NetworkManager/system-connections
				##--include 'iesgallicum' --include 'iesmiguelservet' --include 'iesgudarjavalambre' --include 'carei' --exclude '*'
		fi

		 for FICHERO in $(ls /etc/NetworkManager/system-connections | tr -s " " "*") ; do
		   # Por si tuviera el nombre SSID espacios en blanco:
		   NFICHERO=$(echo $FICHERO | tr -s "*" " ")
		   if test -f "/etc/NetworkManager/system-connections/${NFICHERO}" \
		     -a $(grep "mac-address" "/etc/NetworkManager/system-connections/${NFICHERO}" | wc -c) -lt 20 \
		     && grep "wireless" "/etc/NetworkManager/system-connections/${NFICHERO}" &> /dev/null ; then

		     if sed --follow-symlinks -i \
		     "s/mac-address=.*/mac-address=$MIMAC/g" \
		     "/etc/NetworkManager/system-connections/${NFICHERO}" ; then
		       echo "----> Se ha configurado la MAC de /etc/NetworkManager/system-connections/${NFICHERO}"
		     fi

		   fi
		 done

		 sed --follow-symlinks -i \
		   "s/FIRSTWIRELESS=.*/FIRSTWIRELESS=0/g" \
		   /etc/default/vx-dga-variables/vx-dga-variables-general.conf

	fi

fi
