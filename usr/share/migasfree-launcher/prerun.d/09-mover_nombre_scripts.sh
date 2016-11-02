#!/bin/bash

chmod u+rw,g+r,o+r /usr/share/migasfree-launcher/prerun.d/*.sh
cd /usr/share/migasfree-launcher/prerun.d
for ARCHIVO in $(ls *.casa 2> /dev/null) ; do
	mv $ARCHIVO $(echo $ARCHIVO | awk -F ".casa" '{print $1}')
done

