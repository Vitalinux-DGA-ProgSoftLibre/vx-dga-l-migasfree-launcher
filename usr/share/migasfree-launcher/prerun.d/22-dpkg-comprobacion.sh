#!/bin/bash
# Comprobamos que no se haya quedado ninguna instalación/configuración de paquetes previa a medias
DEBIAN_FRONTEND=noninteractive
DEBCONF_NONINTERACTIVE_SEEN=true
# Configuramos el debconf para dar respuesta a la consulta de configuración del grub:
echo "grub-pc grub-pc/install_devices multiselect /dev/sda" | debconf-set-selections
echo "--> Comprobamos que todos los paquetes instalados actuales se encuentran desempaquetados y correctamente configurados: dpkg --configure -a"
if dpkg --configure -a --force-confdef --force-confold ; then
#if dpkg --configure -a --force-confold | tee /var/log/vitalinux/vx-dpkg-configure.log ; then
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