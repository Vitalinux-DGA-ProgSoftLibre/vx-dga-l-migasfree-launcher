#!/bin/bash
### Asignamos un nombre univoco al atributo Computer_Name de Migasfree (solución al problema con equipos viejos)

# CHECK si tenemos problemas con el UUID. Si es así, debermos indicar un Computer Name diferente para no entrar en conflicto posteriormente!
# Llamar para ello a vx-migasfree-computer-name
# Comprobar si el usuario ha solicitado cambio de nombre en la postinstalación:
#				sed -i "/CAMBIARHOSTNAME.*/d" "${FICHCONF}"
#       sed -i '/Varibles utilizadas por los paquetes/a CAMBIARHOSTNAME=1' "${FICHCONF}"
#				sed -i "/NUEVOHOSTNAME.*/d" "${FICHCONF}"
#				sed -i "/Varibles utilizadas por los paquetes/a NUEVOHOSTNAME=${NAME}" "${FICHCONF}"

#if [ -f $_FIRST ] ; then

  #if grep ".*Computer_Name.*" /etc/migasfree.conf &> /dev/null ; then
  #  mac=$(ifconfig | grep Ethernet | tr -s " " "*" | cut -d"*" -f5 | head -1)
    #rand=$(od -vAn -N4 -tu4 < /dev/random)
    #hname=$(echo $mac $rand | tr -s " " "-")
  #  if sed --follow-symlinks -i "s/.*Computer_Name.*/Computer_Name=$mac/g" /etc/migasfree.conf ; then
  #    echo "--> Se ha asignado a Computer_Name el valor de la MAC $mac"
  #  fi
  #fi

#fi
