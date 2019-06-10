#!/bin/bash

FICHCONFCRON="/etc/default/vx-dga-variables/vx-dga-l-migasfree-launcher-cron.conf"
# Desactivamos MIGASFREE para que sea el servicio CRON quien decida si hay que habilitarlo en el siguiente arranque:

# 1) Comprobamos en FICHCONFCRON la frecuencia programada: 0:daily_every_sessions|7:daily|1:weekly
FRECUENCY="$(crudini --get "${FICHCONFCRON}" "Configuration" "FRECUENCY")"
(( FRECUENCY == 0 )) && crudini --set "${FICHCONFCRON}" "Configuration" "MIGASFREE" "1"
(( FRECUENCY != 0 )) && crudini --set "${FICHCONFCRON}" "Configuration" "MIGASFREE" "0"