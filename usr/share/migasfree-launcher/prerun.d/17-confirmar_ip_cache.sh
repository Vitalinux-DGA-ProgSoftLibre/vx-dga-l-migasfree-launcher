#!/bin/bash
## Indicamos la dirección IP del Servidor Caché en el primer arranque

if [ -f $_FIRST ] && [ ${ENTCASA} = "FALSE" ] ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	TEXTO="Parece ser que esta es la primera vez que arranca este Vitalinux EDU (DGA).\n\n\
Es posible que en tu centro dispongas de un <b>Servidor Caché</b>, cuya función principal es la de <b>cachear y entregar el software que requieran los equipos Vitalinux</b> garantizando una mayor eficiencia de los equipos Vitalinux.\n\n\
Esta configurada por defecto la siguiente dirección IP del servidor Caché: <b>$IPCACHE</b>.  Si no es correcta haz el favor de corregirla.\n\n\
En el caso de que NO dispongas de ningún servidor Caché en el centro, puedes dejar el valor asignado por defecto.\n\n"
	EXITO=1
	VALIDO=0
	while test "${VALIDO}" -eq 0 ; do
		RESPUESTA=$(yad \
		--center \
		--width 700 \
		--window-icon vitalinux \
		--image equipo-torre-64x \
		--title "¿IP del Servidor Caché?" \
		--text-align center --justify="center" \
		--text "${TEXTO}" \
		--form \
		--field="Dirección IP del Servidor Caché: " "${IPCACHE}" \
		--button="Confirmar IP Caché":0 \
		--button="Saltar Paso":1 \
		--button="Salir de la Post-Instalación":2 \
		--buttons-layout center)

		case "${?}" in
			0) 
				CACHE=$(echo ${RESPUESTA} | cut -d"|" -f1)
				# Mediante "sipcalc" comprobamos que se trata de una dirección IP
				if sipcalc ${CACHE} | grep "ERR" &> /dev/null ; then
					TEXTO="¡¡Repasa la IP ${CACHE} Indicada!! \nVuelve a introducir la IP del Servidor Caché, por favor ..."
				else
					if yad --center --width 400 \
						--window-icon vitalinux-64x \
						--image equipo-torre-64x \
						--title "IP del Servidor Caché" \
						--text-align center --justify="center" \
						--text "Por favor confirma la IP Indicada: \n\n ${CACHE}" \
						--button="Corregir IP":1 \
						--button="Confirmar IP":0 \
						--buttons-layout center ; then
					VALIDO=1
					fi
				fi
			;;
			1)
				CACHE="172.30.1.249"
				VALIDO=1
			;;
			2)
				# Cancelamos el proceso de post-instalación:
				vx-cancelar-postinstalacion
				exit 0
			;;
		esac
	done
	if test -f /etc/apt/sources.list.d/vx-dga-repos-mirror.list ; then
		if ! sed --follow-symlinks -i "s/${IPCACHE}/${CACHE}/g" /etc/apt/sources.list.d/vx-dga-repos-mirror.list ; then
			EXITO=0
		fi
	fi
	if test -f /etc/default/vx-dga-variables/vx-dga-variables-general.conf ; then
		if ! sed --follow-symlinks -i "s/IPCACHE=.*/IPCACHE=${CACHE}/g" /etc/default/vx-dga-variables/vx-dga-variables-general.conf ; then
			EXITO=0
		fi
	fi
	if test "${EXITO}" -eq 1 ; then
		echo "=> Se ha asignado al \"IPCACHE\": ${CACHE}"
	fi
fi
