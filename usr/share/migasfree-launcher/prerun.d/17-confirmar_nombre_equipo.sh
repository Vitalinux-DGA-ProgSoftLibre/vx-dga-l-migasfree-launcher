#!/bin/bash

if [ -f $_FIRST ] ; then

	USER=$(whoami)
	NAMEHOST=$(cat /etc/hostname) ## Nombre actual del Equipo

	if test -f /etc/default/vx-dga-variables/vx-dga-variables-general.conf ; then
	. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	fi

	TEXTO="\nEl nombre de su equipo actual es: \"<b>${NAMEHOST}</b>\""
	TEXTO="${TEXTO}\n\n ¿Quieres cambiar el nombre del Equipo?"
	TEXTO="${TEXTO}\n\n(1) Puedes usar cualquier carater alfanumérico"
	TEXTO="${TEXTO}\n(2) Puedes usar puntos y guiones como separadores"
	TEXTO="${TEXTO}\n(3) ¡¡<b>No uses espacios en blanco</b>!!\n\n"
	VALIDO=0

	while test $VALIDO -eq 0 ; do

	if RESULTADO=$(yad --title "Nombre del Equipo" \
		--width="650" --height="100" \
		--center --justify="center" --text-align="fill" \
		--text "${TEXTO}" \
	   	--window-icon vitalinux \
	   	--image vitalinux \
	   	--form --field "Nuevo Nombre para el Equipo: ":CBE "${NAMEHOST}" \
		--button="<b>Modificar Nombre</b>":0 --button="Saltar":1) ; then

		NAME="$(echo ${RESULTADO} | cut -d'|' -f1)"
		IFSANT="${IFS}"
		IFS="."
		NARR=($NAME)
		ST=1
		for i in ${!NARR[@]}; do 
			[ ${#NARR[$i]} -gt 63 ] && { ST=0; break; };
		done
		if [ ${#NAME} -le 253 ] && [ ${#NARR[@]} -le 4 ] && [[ ! "$NAME" =~ [^[:alnum:].-] ]] && [ $ST -eq 1 ] ; then
			VALIDO=1

			sed --follow-symlinks -i "s/${NAMEHOST}/${NAME}/g" /etc/hosts
			sed --follow-symlinks -i "s/${NAMEHOST}/${NAME}/g" /etc/hostname
		else
			TEXTO="\n¡¡Repasa el nombre indicado para el Equipo!!"
			TEXTO="${TEXTO}\n => Nuevo nombre indicado: \"<b>${NAME}</b>\" ¡¡No es correcto!!"
			TEXTO="${TEXTO}\n\nEl nombre de su equipo actual es: \"<b>${NAMEHOST}</b>\""
			TEXTO="${TEXTO}\n\n(1) Puedes usar cualquier carater alfanumérico"
			TEXTO="${TEXTO}\n(2) Puedes usar puntos y guiones como separadores"
			TEXTO="${TEXTO}\n(3) ¡¡<b>No uses espacios en blanco</b>!!\n\n"
		fi
		IFS="${IFSANT}"
	else
		VALIDO=1
	fi

	done

fi
