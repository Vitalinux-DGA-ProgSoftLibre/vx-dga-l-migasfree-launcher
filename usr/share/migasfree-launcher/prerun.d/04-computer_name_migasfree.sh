### Asignamos un nombre univoco al atributo Computer_Name de Migasfree (solución al problema con equipos viejos)
if [ -f $_FIRST ] ; then

if grep ".*Computer_Name.*" /etc/migasfree.conf &> /dev/null ; then
  mac=$(ifconfig | grep Ethernet | tr -s " " "*" | cut -d"*" -f5 | head -1)
  #rand=$(od -vAn -N4 -tu4 < /dev/random)
  #hname=$(echo $mac $rand | tr -s " " "-")
	if sed --follow-symlinks -i "s/.*Computer_Name.*/Computer_Name=$mac/g" /etc/migasfree.conf ; then
		echo "--> Se ha asignado a Computer_Name el valor de la MAC $mac"
	fi
fi

fi
