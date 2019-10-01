#!/bin/bash
## Damos la opción a los equipos con la etiqueta ENT-CASA el deshabilitar el Cliente Migasfree desde el principio

if [ -f $_FIRST ] && [ ${ENTCASA} = "TRUE" ] ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	TEXTO="<b>Vitalinux</b> se diferencia de cualquier otro Sistema Linux en que incorpora un <b>cliente Migasfree</b>"
  	TEXTO="${TEXTO}\nEste cliente  permite la gestión a demanda de tu Vitalinux desde un <b>servidor central</b>."
  	TEXTO="${TEXTO}\nAl deshabilitarlo <b>saldrás también de la Post-Instalación</b> y \ntu Vitalinux se comportará como cualquier otro Linux ..." 
  	TEXTO="${TEXTO}\n\n<b><tt><span foreground='blue'>¿Quieres deshabilitarlo?</span></tt></b>"

	RESPUESTA=$(yad --center --width 720 \
		--window-icon vitalinux \
		--image migasfree \
		--title "Desactivar el Cliente Migasfree" \
		--text-align center --justify="center" \
		--text "${TEXTO}" \
		--form \
		--field="Marca esta casilla para confirmar su Deshabilitación":CHK FALSE \
		--button="Continuar":0 \
		--button="Salir de la Post-Instalación":1 \
		--buttons-layout center)
	case "${?}" in
		0)
		if echo ${RESPUESTA} | grep "TRUE" &> /dev/null ; then
			FICHEXE="/usr/bin/vx-conf-migasfree-launcher-cli"
			if test -f "${FICHEXE}" ; then
				echo "=> Se ha dado la orden de deshabilitar el cliente migasfree ..."
				/usr/bin/vx-conf-migasfree-launcher-cli "deshabilitar"
				vx-kill-cliente-migasfree
			fi
		fi
		;;
		*)
			# Cancelamos el proceso de post-instalación:
			vx-cancelar-postinstalacion
			exit 0
		;;
	esac
fi
