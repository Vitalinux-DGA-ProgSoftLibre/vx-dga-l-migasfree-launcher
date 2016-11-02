# Paquete DEB vx-dga-l-migasfree-launcher

Paquete basado en el software Virtual Magnifying Glass (vmg) que nos permite agrandar un área de la pantalla.

# Usuarios Destinatarios

Muy útil para usuarios con dificultades visuales.

# Aspectos Interesantes: Teclas útiles de Virtual Magnifying Glass (vmg)
```
[ ENTER ] or [ ESC ] --> Hides the glass
Q --> Closes the application
Up --> Arrow Increases the lens height
Down Arrow --> Decreases the lens height
Right Arrow  --> Increases the lens width
Left Arrow  --> Decreases the lens width
W  --> Moves the lens up
S  --> Moves the lens down
D  --> Moves the lens to the right
A  --> Moves the lens to the left
[ PAGE UP ] --> Moves the lens up in big steps
[ PAGE DOWN ] --> Moves the lens down in big steps
B --> Activates and Deactivates the graphical border
[MOUSE WHELL UP] --> Increase the magnification in small steps
[MOUSE WHELL DOWN] --> Decrease the magnification in small steps
+ --> Increase the magnification in small steps
- --> Decrease the magnification in small steps
```
# Como Crear el paquete DEB a partir del codigo de GitHub
Para crear el paquete DEB será necesario encontrarse dentro del directorio donde localizan los directorios que componen el paquete.  Una vez allí, se ejecutará el siguiente comando (es necesario tener instalados los paquetes apt-get install debhelper devscripts):

```
apt-get install debhelper devscripts
/usr/bin/debuild --no-tgz-check -us -uc
```

# Como Instalar el paquete generado vx-dga-l-lupa*.deb:
Para la instalación de paquetes que estan en el equipo local puede hacerse uso de ***dpkg*** o de ***gdebi***, siendo este último el más aconsejado para que se instalen también las dependencias correspondientes.
```
gdebi vx-dga-l-lupa*.deb
```
