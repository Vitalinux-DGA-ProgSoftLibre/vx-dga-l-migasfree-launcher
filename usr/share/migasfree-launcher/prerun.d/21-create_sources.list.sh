MIRROR_SERVER="http://mirror.vitalinux.educa.aragon.es"
#VXREPOSMIRROR="/usr/share/vitalinux/sources.list.d/vx-dga-repos-mirror.list"
SOURCESMIRROR_OLD="/etc/apt/sources.list.d/vx-dga-repos-mirror.list"
#SOURCESGOOGLECHROME="/etc/apt/sources.list.d/google-chrome.list"
#SOURCESLIBREOFFICE="/etc/apt/sources"

function create_source_list(){
    local _SRV=$1
    local proxy_file="/etc/apt/apt.conf.d/01cache_proxy"
. /etc/default/vx-dga-variables/vx-dga-variables-general.conf
	#Comprobamos lo primero si el servidor caché está en la red
	if ping -c 1 $IPCACHE && nc -zv $IPCACHE 3142 > /dev/null 2>&1
	then
		echo "--> Servidor Cache que ofrece servicio APT-CACHER ..."
		echo "--> Se va a configurar al Servidor Cache como servidor APT-CACHER de software ..."
		
		echo "# Mod por migasfree-launcher: Hay conexión con el servidor APT-CACHER $IPCACHE" > /etc/apt/sources.list
		
		#Configuramos apt-proxy
		echo "Acquire::http { Proxy \"http://$IPCACHE:3142\"; };" > $proxy_file
		echo 'Acquire::https { Proxy "false"; };' >> $proxy_file
	else	
		echo "# Mod por migasfree-launcher: NO hay conexión con algun servidor Caché" > /etc/apt/sources.list
		# Borrar el posible archivo generado anteriormente del proxy-cache
		if test -f $proxy_file ; then
			rm -f $proxy_file
		fi
	fi
# Crearmos las lineas del mirror
cat >> /etc/apt/sources.list<<EOF
# Ubuntu Base Respositorios
deb ${_SRV}/ubuntu trusty main restricted universe multiverse
deb ${_SRV}/ubuntu trusty-updates main restricted universe multiverse
deb ${_SRV}/ubuntu trusty-security main restricted multiverse universe

# Libre Office 5.2 Repositorios
deb ${_SRV}/libreoffice-5-2 trusty main

# Chrome. Solo para 64 bits
deb [arch=amd64] ${_SRV}/google stable main
EOF
}

# Función para revisar e instalar claves. Primer parámetro es la clave y segundo el servidor de claves
function install_apt_key(){
if ! apt-key list | grep ${1} > /dev/null 2> /dev/null ; then
	echo "Clave ${1} no encontrada...Instalando"
	apt-key adv --keyserver ${2} --recv-keys ${1}
	return $?
fi
}

echo "--> Seguimos con la creación del sources.list ...."

# Revisión e instalación de las claves necesarias:
# Libreoffice
install_apt_key 1378B444 keyserver.ubuntu.com
# Chrome. No hace uso del servidores de claves, sino de uno propio
if ! apt-key list | grep 640DB551 > /dev/null 2> /dev/null ; then
	echo "Clave Google no encontrada...Instalando"
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
fi
# Limpiar los sources que existan antiguos
# Libreoffice
find /etc/apt/sources.list.d/ -regextype posix-egrep -regex '.*libreoffice.*list$' -exec mv '{}' '{}'.save \;
# Chrome
find /etc/apt/sources.list.d/ -regextype posix-egrep -regex '.*chrome.*list$' -exec mv '{}' '{}'.save \;
# Limpiamos cualquier resto antiguo de mirror caches v7
if test -f ${SOURCESMIRROR_OLD} ; then
		mv ${SOURCESMIRROR} ${SOURCESMIRROR_OLD}.save
fi
# Creamos el sources.list
create_source_list $MIRROR_SERVER