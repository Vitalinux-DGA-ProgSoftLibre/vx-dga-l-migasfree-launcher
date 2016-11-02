# Install broadcom 43xx without inet
if [ -f $_FIRST ] ; then
	if test -f /usr/bin/obtener-resolucion-pantalla -a -f /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png -a -f /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png ; then

		RESOLUCION=$(/usr/bin/obtener-resolucion-pantalla)
		if test "$RESOLUCION" == "" ; then
			echo "--> Se ha detectado una resolución de pantalla Indeterminada ..."
			RESOLUCION="Indeterminada"
		else
			echo "--> Se ha detectado una resolución de pantalla de $RESOLUCION ..."
		fi
		_FILE1=/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper.png
		_FILE2=/usr/share/lubuntu/wallpapers/vitalinux-login.png

		case $RESOLUCION in
			"4:3" )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png \
				/usr/share/divert$_FILE1 && \
				ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-4x3-1600x1200.png \
				/usr/share/divert$_FILE2 ; then
				echo "--> Se configurado los Wallpapers para la resolución de 4:3 ..."
			else
				echo "--> Se iba a configurar los Wallpapers para la resolución de 4:3 y ha habido algún problema con la creación de los enlaces simbólicos ..."
			fi
			;;
			"16:9" )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png \
				/usr/share/divert$_FILE1 && \
				ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-16x9-1920x1080.png \
				/usr/share/divert$_FILE2 ; then
				echo "--> Se configurado los Wallpapers para la resolución de 16:9 ..."
			else
				echo "--> Se iba a configurar los Wallpapers para la resolución de 16:9 y ha habido algún problema con la creación de los enlaces simbólicos ..."
			fi
			;;
			* )
			if ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png \
				/usr/share/divert$_FILE1 && \
			ln -sf /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-login-16x9-1920x1080.png \
				/usr/share/divert$_FILE2 ; then
				echo "--> Se configurado los Wallpapers para la resolución de 16:9 a pesar de que la resolución es $RESOLUCION ..."
			else
				echo "--> Se iba a configurar los Wallpapers para la resolución de 16:9 a pesar de que la resolución es $RESOLUCION y ha habido algún problema con la creación de los enlaces simbólicos ..."
			fi
			;;
		esac
	else
		echo "--> Error Fondo Imagen: No existen /usr/bin/obtener-resolucion-pantalla o /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-4x3-1600x1200.png o /usr/share/divert/usr/share/lubuntu/wallpapers/vitalinux-edu-wallpaper-16x9-1920x1080.png ..."
	fi
fi

