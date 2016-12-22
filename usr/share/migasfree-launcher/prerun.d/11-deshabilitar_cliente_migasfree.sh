#!/bin/bash
## Damos la opción a los equipos con la etiqueta ENT-CASA el deshabilitar el Cliente Migasfree desde el principio

if [ -f $_FIRST ] && [ ${ENTCASA} = "TRUE" ] ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	TEXTO="<b>Vitalinux</b> se diferencia de cualquier otro Sistema Linux en que incorpora un <b>cliente Migasfree</b>"
  	TEXTO="${TEXTO}\n\nEste cliente  permite la gestión a demanda de tu Vitalinux desde un <b>servidor central</b>"
  	TEXTO="${TEXTO}\n\n<b><tt><span foreground='blue'>¿Quieres deshabilitarlo?</span></tt></b>"

	if RESPUESTA=$(yad --center --width 720 \
		--window-icon vitalinux \
		--image migasfree \
		--title "Desactivar el Cliente Migasfree" \
		--text-align center --justify="center" \
		--text "${TEXTO}" \
		--form \
		--field="Marca esta casilla para confirmar su Deshabilitación":CHK FALSE \
		--button="Continuar" \
		--buttons-layout center) ; then
		if echo ${RESPUESTA} | grep "TRUE" &> /dev/null ; then
			if test -f /usr/bin/vx-configurar-migasfree-launcher-cli ; then
				/usr/bin/vx-configurar-migasfree-launcher-cli "deshabilitar"
			fi
		fi
	fi
fi
