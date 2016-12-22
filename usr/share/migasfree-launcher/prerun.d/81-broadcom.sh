# Install broadcom 43xx without inet
if [ -f $_FIRST ] ; then
  lspci -n | awk '{print $3}' | grep "14e4:43"
  if [ $? = 0 ] ; then
    echo "----------------------------"
    echo "Se debería Instalar broadcom-43XX ..."
    apt-get --assume-yes --force-yes install firmware-b43-installer firmware-b43legacy-installer

    #dpkg -i /opt/pkgs/b43-fwcutter_*.deb
    #dpkg -i /opt/pkgs/vx-broadcom-43_*.deb

  fi
fi

