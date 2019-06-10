#!/bin/bash

if [ -f $_FIRST ] ; then

	if RESULTADO=$(yad --title "¡¡Bienvenid@ a Vitalinux EDU DGA!!" --center \
		--text-align center \
		--text "  ¡¡Bienvenid@ a <b>Vitalinux EDU DGA!!</b>  \n  En esta breve Post-Instalación deberás indicar en   \n  primer lugar el uso que vas a hacer del sistema.  \n\n  En el caso de que estés trabajando en <b>modo Live</b>, \n  te sugerimos <b><i>Salir de la Post-Instalación</i></b> a menos que \n necesites que se actualice Vitalinux:   " \
		--window-icon vitalinux-64x \
		--image vitalinux-64x \
		--width=580 --height=300 \
		--list --radiolist  \
		--column Opcion:RD \
		--column Descripcion:TEXT \
		--column Numero:HD \
		TRUE "Voy a usar Vitalinux asociado a un Centro Educativo" "1" \
		FALSE "Voy a usar Vitalinux en casa, o fuera de un centro Educativo" "2" \
		--button="Continuar con la Post-Instalación":0 \
		--button="Salir de la Post-Instalación":1 \
		--buttons-layout center) ; then

		OPCION=$(echo $RESULTADO | cut -d"|" -f3)
		if ! test -d /var/tmp/migasfree ; then
			mkdir -p /var/tmp/migasfree
		fi
		chmod 755 /var/tmp/migasfree
		chmod u+rw,g+r,o+r /usr/share/migasfree-launcher/prerun.d/*.sh
		case $OPCION in
			"1" ) # Sique el proceso normal de ejecución de scripts prerun.d
				echo "" > /var/tmp/migasfree/first-tags.conf
				chmod 644 /var/tmp/migasfree/first-tags.conf
			;;
			"2" )
				ENTCASA="TRUE"
				#chmod 000 /usr/share/migasfree-launcher/prerun.d/01-confirmar_ip_cache.sh
				#chmod 000 /usr/share/migasfree-launcher/prerun.d/02-usuario_inicio_sesion.sh

				echo "ENT-CASA" > /var/tmp/migasfree/first-tags.conf
				chmod 644 /var/tmp/migasfree/first-tags.conf
			;;
		esac

	else
		# Cancelamos el proceso de post-instalación:
		vx-cancelar-postinstalacion
	fi

fi
