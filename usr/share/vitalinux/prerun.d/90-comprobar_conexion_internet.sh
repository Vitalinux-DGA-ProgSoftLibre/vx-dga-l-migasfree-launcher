#!/bin/bash

if test -f /etc/default/vx-dga-variables/vx-dga-variables-general.conf ; then
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
fi

if [ -f $_FIRST ] && \
  ( [ -z ${MOSTRAR_AVISO_CONECTIVIDAD} ] || [ ${MOSTRAR_AVISO_CONECTIVIDAD} -eq 1 ] ) ; then

  SERVIDOR="migasfree.educa.aragon.es"
  let _retries=0
  until wget -O /tmp/inet_connection_migasfree ${SERVIDOR} &> /dev/null ; do
    if [ $_retries -le 10 ] ; then
      sleep 1 # 1*10" = 10 sg.
      let _retries=_retries+1
      echo $_retries
    else
      # No hay conexión al servidor: damos aviso de problema de conectividad.
      TEXTO="\t\t<b><tt><span foreground='blue'>¡¡Gracias por Instalar Vitalinux!!</span></tt></b>"
      TEXTO="${TEXTO}\n\nLa instalación de Vitalinux en tu equipo ha sido satisfactoria.  No obstante,"
      TEXTO="${TEXTO}\nte informamos de que <b>Vitalinux requiere de una post-instalación</b> para poder"
      TEXTO="${TEXTO}\nconfigurar el <b>cliente Migasfree</b> que trae preinstalado <b><tt><span foreground='red'>(opcional)</span></tt></b>."
      TEXTO="${TEXTO}\nEste <b>cliente Migasfree</b> permite la gestión y correcto mantenimiento de Vitalinux"
      TEXTO="${TEXTO}\nde manera remota y desatendida."
      TEXTO="${TEXTO}\n\n<b>¡¡Problemas!!</b> Para poder llevar a cabo la <b>post-instalación</b> se requiere"
      TEXTO="${TEXTO}\nconexión con Internet y aparentemente este equipo no esta configurado para ello."
      TEXTO="${TEXTO}\nPor este motivo te sugerimos los siguiente:"
      TEXTO="${TEXTO}\n\t<b>(1)</b> Conecta un cable de red (Ethernet) al equipo y si es necesario asigna"
      TEXTO="${TEXTO}\n\tuna dirección IP estática al equipo"
      TEXTO="${TEXTO}\n\t<b>(2)</b> Si dispones de una interfaz Wireless selecciona alguna de las redes Wireless"
      TEXTO="${TEXTO}\n\tdisponibles pinchando sobre el icono de red de la barra inferior del Escritorio\n\n"

      if RESPUESTA=$(yad --title "Aviso de Fallo de Conectividad" \
        --center \
        --image preferences-system-network \
        --width 700 --height 450 \
        --window-icon vitalinux \
        --text "${TEXTO}" \
        --always-print-result \
        --form \
        --field "No volver a mostrar este Mensaje":CHK FALSE \
        --buttons-layout center \
        --button "Configurar Red Cableada":0 --button "Salir - Entendido":1) ; then
        EVITARMENSAJE="$(echo ${RESPUESTA} | cut -d'|' -f1)"
        if [ "${EVITARMENSAJE}" = "TRUE" ] ; then
          sed -i '/Varibles utilizadas por los paquetes/a MOSTRAR_AVISO_CONECTIVIDAD=0' \
            /etc/default/vx-dga-variables/vx-dga-variables-general.conf
        fi

        nm-connection-editor
      else
        EVITARMENSAJE="$(echo ${RESPUESTA} | cut -d'|' -f1)"
        if [ "${EVITARMENSAJE}" = "TRUE" ] ; then
          sed -i '/Varibles utilizadas por los paquetes/a MOSTRAR_AVISO_CONECTIVIDAD=0' \
            /etc/default/vx-dga-variables/vx-dga-variables-general.conf
        fi
      fi
      echo "--------------------------------"
      echo "No hay conexion con ${SERVIDOR}. Se cancela."

      exit 1
    fi
  done
  rm /tmp/inet_connection_migasfree


fi
