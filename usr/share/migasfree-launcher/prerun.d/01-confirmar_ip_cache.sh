## Indicamos la dirección IP del Servidor Caché en el primer arranque

if [ -f $_FIRST ] ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	TEXTO="Parece ser que esta es la primera vez que arranca este Vitalinux EDU (DGA).\n\n\
Es posible que en tu centro dispongas de un <b>Servidor Caché</b>, cuya función principal es la de <b>cachear y entregar el software que requieran los equipos Vitalinux</b> garantizando una mayor eficiencia de los equipos Vitalinux.\n\n\
Esta configurada por defecto la siguiente dirección IP del servidor Caché: <b>$IPCACHE</b>.  Si no es correcta haz el favor de corregirla.\n\n\
En el caso de que NO dispongas de ningún servidor Caché en el centro, puedes dejar el valor asignado por defecto.\n\n"
	VALIDO=0
	while test $VALIDO -eq 0 ; do
		RESPUESTA=$(yad --center --width 640 \
		--window-icon vitalinux-64x \
		--image equipo-torre-64x \
		--title "IP del Servidor Caché" \
		--text-align center --justify="center" \
		--text "$TEXTO" \
		--form \
		--field="Dirección IP del Servidor Caché: " "$IPCACHE" \
		--button="Confirmar IP Caché")
		CACHE=$(echo $RESPUESTA | cut -d"|" -f1)
		if test $(expr length "$CACHE") -le 6 \
			-o "$(echo "$CACHE" | awk -F'.' '{ print $4 }')" == "" ; then
			TEXTO="¡¡Repasa la IP $CACHE Indicada!! \nVuelve a introducir la IP del Servidor Caché, por favor ..."
		else
			if yad --center --width 400 \
				--window-icon vitalinux-64x \
				--image equipo-torre-64x \
				--title "IP del Servidor Caché" \
				--text-align center --justify="center" \
				--text "Por favor confirma la la IP Indicada: \n\n $CACHE" \
				--button="Corregir IP":1 --button="Confirmar IP":0 ; then
			VALIDO=1
			fi
		fi
	done
	if test -f /etc/apt/sources.list.d/vx-dga-repos-mirror.list ; then
		sed --follow-symlinks -i "s/$IPCACHE/$CACHE/g" /etc/apt/sources.list.d/vx-dga-repos-mirror.list
	fi
	if test -f /etc/default/vx-dga-variables/vx-dga-variables-general.conf ; then
		sed --follow-symlinks -i "s/IPCACHE=.*/IPCACHE=$CACHE/g" /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	fi
fi
