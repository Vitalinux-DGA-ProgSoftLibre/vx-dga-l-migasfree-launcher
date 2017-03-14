#!/bin/bash
# Deshabilitamos por defecto en el primer arranque el Dock Plank y el Gnome-Pie

if [ -f $_FIRST ] ; then
# Deshabilitamos el Dock Plank
	if test -f /etc/xdg/autostart/lanzar-dock-plank.desktop ; then
		if chmod 000 /etc/xdg/autostart/lanzar-dock-plank.desktop ; then
			echo "=> $(date) - Se ha deshabilitado el Dock Plank por defecto ..." >> ${LOGVX}
		fi
	fi
	for HOMEUSU in $( getent passwd | awk -F ":" '{if ( $3 > 999 &&  $7~/\/bin\/.*/) {print $6}}' ) ; do
	  if test -f $HOMEUSU/.config/lxsession/Lubuntu/autostart ; then
		 sed --follow-symlinks -i "/.*plank.*/d" $HOMEUSU/.config/lxsession/Lubuntu/autostart
	  fi
	done
# Deshabilitamos el dock circular Gnome-pie
	if test -f /etc/xdg/autostart/gnome-pie.desktop ; then
		if chmod 000 /etc/xdg/autostart/gnome-pie.desktop ; then
			echo "=> $(date) - Se ha deshabilitado el dock circular Gnome Pie por defecto ..." >> ${LOGVX}
		fi
	fi

	for HOMEUSU in $( getent passwd | awk -F ":" '{if ( $3 > 999 &&  $7~/\/bin\/.*/) {print $6}}' ) ; do
	  if test -f  $HOMEUSU/.config/autostart/gnome-pie.desktop ; then
		 chmod 000 $HOMEUSU/.config/autostart/gnome-pie.desktop
	  fi
	done

fi


