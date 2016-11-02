_SERVER_SOURCE_LIST="http://fr.archive.ubuntu.com/ubuntu"
VXREPOSMIRROR="/usr/share/vitalinux/sources.list.d/vx-dga-repos-mirror.list"
SOURCESMIRROR="/etc/apt/sources.list.d/vx-dga-repos-mirror.list"
SOURCESGOOGLECHROME="/etc/apt/sources.list.d/google-chrome.list"

function create_source_list(){
    local _SRV=$1
    local proxy_file="/etc/apt/apt.conf.d/01cache_proxy"
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	#Comprobamos lo primero si el servidor caché está en la red
	if ping -c 1 $IPCACHE
	then
		echo "--> Ok!! Hay conexión con el Servidor Cache vía ping ..."
		if nc -zv $IPCACHE 3142 > /dev/null 2>&1
		then
			echo "--> Ok!! El Servidor Cache ofrece servicio APT-CACHER ..."
			echo "--> Se va a configurar al Servidor Cache como servidor APT-CACHER de software ..."
			#Tenemos el proxy . Aseguramos que los repos sin pasar por apt-mirror
			if test -f ${SOURCESMIRROR} ; then
				sed --follow-symlinks -i 's/^deb/#deb/g' ${SOURCESMIRROR}
			fi
			cat > /etc/apt/sources.list<<EOF
# Hay conexión con el servidor APT-CACHER $IPCACHE
deb $_SRV trusty main restricted universe multiverse
deb $_SRV trusty-updates main restricted universe multiverse
deb $_SRV trusty-security main restricted multiverse universe
EOF
			if test -f ${SOURCESGOOGLECHROME} ; then
				# Lo mismo para los repositorios de google-chrome
				sed --follow-symlinks -i 's/^#deb/deb/g' ${SOURCESGOOGLECHROME}
			fi
			#Configuramos apt-proxy
			echo "Acquire::http { Proxy \"http://$IPCACHE:3142\"; };" > $proxy_file
			echo 'Acquire::https { Proxy "false"; };' >> $proxy_file
		else
			if wget http://$IPCACHE/fr.archive.ubuntu.com -O /tmp/comprobar-wget &> /dev/null ; then
				#Tenemos caché pero en version mirror-debian7 (apt-mirror)
				cat $VXREPOSMIRROR > ${SOURCESMIRROR}
				sed --follow-symlinks -i "s/IPCACHE/$IPCACHE/" ${SOURCESMIRROR}
				##sed -i 's/^#deb/deb/g' /etc/apt/sources.list.d/vx-dga-repos-mirror.list
				cat > /etc/apt/sources.list<<EOF
# Hay conexión con el servidor Caché v.7 como MIRROR de Software - Este le suministrará el software
EOF
				# Lo mismo para los repositorios de google-chrome
				if test -f ${SOURCESGOOGLECHROME} ; then
					sed --follow-symlinks -i 's/^deb/#deb/g' ${SOURCESGOOGLECHROME}
				fi
				# Borrar el posible archivo generado anteriormente del proxy-cache
				if test -f $proxy_file ; then
					rm -f $proxy_file
				fi
			else
				if test -f ${SOURCESMIRROR} ; then
					sed --follow-symlinks -i 's/^deb/#deb/g' ${SOURCESMIRROR}
				fi
				cat > /etc/apt/sources.list<<EOF
# No hay conexión con algun servidor Caché - Haremos uso de repositorios oficiales
deb $_SRV trusty main restricted universe multiverse
deb $_SRV trusty-updates main restricted universe multiverse
deb $_SRV trusty-security main restricted multiverse universe
EOF
				if test -f ${SOURCESGOOGLECHROME} ; then
					# Lo mismo para los repositorios de google-chrome
					sed --follow-symlinks -i 's/^#deb/deb/g' ${SOURCESGOOGLECHROME}
				fi
				# Borrar el posible archivo generado anteriormente del proxy-cache
				if test -f $proxy_file ; then
					rm -f $proxy_file
				fi
			fi
		fi
	else
		echo "--> ¡¡No Hay conexión con el Servidor Cache!! ..."
		echo "--> Se obtendra el software necesario directamente de los repositorios oficiales ..."
		#No tenemos acceso al cache. Repos a internet
		if test -f ${SOURCESMIRROR} ; then
			sed --follow-symlinks -i 's/^deb/#deb/g' ${SOURCESMIRROR}
		fi
		cat > /etc/apt/sources.list<<EOF
# No hay conexión con algun servidor Caché - Haremos uso de repositorios oficiales
deb $_SRV trusty main restricted universe multiverse
deb $_SRV trusty-updates main restricted universe multiverse
deb $_SRV trusty-security main restricted multiverse universe
EOF
		if test -f /etc/apt/sources.list.d/google-chrome.list ; then
			# Lo mismo para los repositorios de google-chrome
			sed --follow-symlinks -i 's/^#deb/deb/g' /etc/apt/sources.list.d/google-chrome.list
		fi
		# Borrar el posible archivo generado anteriormente del proxy-cache
		if test -f $proxy_file ; then
			rm -f $proxy_file
		fi
	fi
}

# sources.list
create_source_list $_SERVER_SOURCE_LIST
