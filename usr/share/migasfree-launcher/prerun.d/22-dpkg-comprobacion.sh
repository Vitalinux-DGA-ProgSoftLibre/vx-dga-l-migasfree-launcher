#!/bin/bash
# Comprobamos que no se haya quedado ninguna instalación/configuración de paquetes previa a medias
echo "--> Comprobamos que todos los paquetes instalados actuales se encuentran desempaquetados y correctamente configurados: dpkg --configure -a"
if dpkg --configure -a ; then
	echo "--| Todo desempaquetado y configurado |--> Todo Ok!!"
else
	echo "--| Anomalías al desempaquetar y configurar |--> Comprobar!!"
fi
echo "--> Comprobamos que no hay dependencias de paquetes incumplidas o pendientes de instalación: apt-get install -f"
if apt-get -f --assume-yes --force-yes install ; then
	echo "--| Todo lo pendiente ya instalado |--> Todo Ok!!"
else
	echo "--| Anomalías al instalar paquetes pendientes de instalación |--> Comprobar!!"
fi

