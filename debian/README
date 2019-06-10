# Paquete DEB vx-dga-l-migasfree-launcher

Paquete encargado de personalizar el comportamiento del migasfree-launcher o migasfree-tray.  En concreto, define los scripts que queremos que se ejecuten antes y después de la comunicación con el servidor migasfree tras cada inicio de sesión del equipo.

# Usuarios Destinatarios

Todos los equipos Vitalinux EDU DGA

# Aspectos Interesantes:
Para lanzar nuevos scripts tan solo es necesio añadirlos en prerun o postrun.
```
Ninguno
```
# Como Crear el paquete DEB a partir del codigo de GitHub
Para crear el paquete DEB será necesario encontrarse dentro del directorio donde localizan los directorios que componen el paquete.  Una vez allí, se ejecutará el siguiente comando (es necesario tener instalados los paquetes apt-get install debhelper devscripts):

```
apt-get install debhelper devscripts
/usr/bin/debuild --no-tgz-check -us -uc
```

# Como Instalar el paquete generado vx-dga-l-*.deb:
Para la instalación de paquetes que estan en el equipo local puede hacerse uso de ***dpkg*** o de ***gdebi***, siendo este último el más aconsejado para que se instalen también las dependencias correspondientes.
```
gdebi vx-dga-l-*.deb
```
