# Install broadcom 43xx without inet
if [ -f $_FIRST ] ; then
	if test -f /usr/bin/obtener-resolucion-pantalla -a -f /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png -a -f /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png ; then

		RESOLUCION=$(/usr/bin/obtener-resolucion-pantalla)
		if test "$RESOLUCION" == "" ; then
			echo "=> $(date) - Se ha detectado una resolución de pantalla Indeterminada ..." >> ${LOGVX}
			RESOLUCION="Indeterminada"
		else
			echo "=> $(date) - Se ha detectado una resolución de pantalla de $RESOLUCION ..." >> ${LOGVX}
		fi
		_FILE1=/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper.png
		_FILE2=/usr/share/lubuntu/wallpapers/vitalinux-login.png

		case $RESOLUCION in
			"4:3" )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png \
				/usr/share/divert$_FILE1 && \
				ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-4x3-1600x1200.png \
				/usr/share/divert$_FILE2 ; then
				echo "=> $(date) - Se configurado los Wallpapers para la resolución de 4:3 ..." >> ${LOGVX}
			else
				echo "=> $(date) - Se iba a configurar los Wallpapers para la resolución de 4:3 y ha habido algún problema con la creación de los enlaces simbólicos ..." >> ${LOGVX}
			fi
			;;
			"16:9" )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png \
				/usr/share/divert$_FILE1 && \
				ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-16x9-1920x1080.png \
				/usr/share/divert$_FILE2 ; then
				echo "=> $(date) - Se configurado los Wallpapers para la resolución de 16:9 ..." >> ${LOGVX}
			else
				echo "=> $(date) - Se iba a configurar los Wallpapers para la resolución de 16:9 y ha habido algún problema con la creación de los enlaces simbólicos ..." >> ${LOGVX}
			fi
			;;
			* )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png \
				/usr/share/divert$_FILE1 && \
			ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-16x9-1920x1080.png \
				/usr/share/divert$_FILE2 ; then
				echo "=> $(date) - Se configurado los Wallpapers para la resolución de 16:9 a pesar de que la resolución es $RESOLUCION ..." >> ${LOGVX}
			else
				echo "=> $(date) - Se iba a configurar los Wallpapers para la resolución de 16:9 a pesar de que la resolución es $RESOLUCION y ha habido algún problema con la creación de los enlaces simbólicos ..." >> ${LOGVX}
			fi
			;;
		esac
	else
		echo "=> $(date) - Error Fondo Imagen: No existen /usr/bin/obtener-resolucion-pantalla o /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png o /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png ..." >> ${LOGVX}
	fi
fi

