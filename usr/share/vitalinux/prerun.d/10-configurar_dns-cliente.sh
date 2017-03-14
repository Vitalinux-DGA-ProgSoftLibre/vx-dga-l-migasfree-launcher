# Configuramos el resolutor de nombres deseado

if [ -f $_FIRST ] ; then

  echo "=> $(date) - Configurando el resolutor de nombres DNS ..." >> ${LOGVX}
  if test -f /etc/resolvconf/resolv.conf.d/base ; then
	echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/base
  fi
  resolvconf -u
  if [[ -f /run/resolvconf/resolv.conf ]] && ! grep "^nameserver" /run/resolvconf/resolv.conf ; then
	echo "nameserver 8.8.8.8" > /run/resolvconf/resolv.conf
  fi
  if ! test -L /etc/resolv.conf ; then
	ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
  fi

fi
