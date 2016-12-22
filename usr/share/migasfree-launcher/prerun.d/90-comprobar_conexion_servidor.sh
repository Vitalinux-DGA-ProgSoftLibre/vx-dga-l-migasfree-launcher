  # Wait inet connection (3 minutes max.)

##if [ -f $_FIRST ] ; then

  let _retries=0
  until wget -O /tmp/inet_connection $_SERVER &> /dev/null
  do
    if [ $_retries -le 18 ] ; then
      sleep 10 # 18*10" = 3 min.
      let _retries=_retries+1
      echo $_retries
    else
      # No hay conexión al servidor y salimos.
      echo "--------------------------------"
      echo "No hay conexion con $_SERVER. Se cancela."
      exit 1
    fi
  done
  rm /tmp/inet_connection


##fi
