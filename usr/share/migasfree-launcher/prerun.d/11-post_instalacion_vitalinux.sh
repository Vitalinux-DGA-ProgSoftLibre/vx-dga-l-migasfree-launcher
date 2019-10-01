#!/bin/bash

if [ -f $_FIRST ] ; then
    
    if [[ "$SUDO_UID" != "999" ]] ; then
        echo "=> Registrando el equipo en Migasfree ..."
        echo "s" | LC_ALL=C migasfree --register
        echo "=> Solicitando datos para la post-instalación de Vitalinux ..."
        #/usr/bin/migasfree-tags --communicate $_TAGS
        ## Para evitar problemas de permisos en:
        ## ".config/Migasfree Tags Managament" y ".cache/Migasfree Tags Managament"
        ## lo lanzará el usuario gráfico:
        ## su "${_USER}" -c 'nw /usr/share/vitalinux/nwjs-apps/nwjs-migasfree-tags' --login
        # /mnt/nwjs-sdk-v0.36.2-linux-x64/nw /usr/share/vitalinux/nwjs-apps/vue-vx-postinstall-dist 2> /dev/null
        cd "/usr/share/vitalinux/nwjs-apps/vue-vx-postinstall-dist" && nw . 2> /dev/null
    fi
fi
