#!/bin/bash
## Indicamos el usuario con que queremos que inicie de manera automatica

USER=$(whoami)

ACTUAL=$(cat /etc/lightdm/lightdm.conf | grep "autologin-user=" | cut -d "=" -f2)
USUARIOSEXISTENTES=$(awk -F ":" '{if ( $3 > 999 && $6~/\/home\/.*/) {print $1}}' /etc/passwd | tr -s "\n" " ")

TEXTO1="  Actualmente el equipo inicia sesión automática con el usuario: \n  <b>$(echo $ACTUAL | cut -d' ' -f1)</b>  \n\n  Selecciona el Usuario con quien deseas que el equipo inicie <b>Sesión de manera Automática</b>:  "
TEXTO2="  Actualmente el equipo <b>NO</b> inicia Sesión Automática con ningún usuario.  \n\n  Selecciona el Usuario con quien deseas que el equipo inicie <b>Sesión de manera Automática</b>:  "
USERDEFINITIVO=""

function eliminar-usuarios-del-sistema {

	TEXTO="¿Quieres <b>eliminar o modificar los usuarios predefinidos</b> que existen en el sistema?\n\n\
<b>Vitalinux EDU DGA</b> es un sistema que viene con unas cuentas preconfiguradas: <b>alumno, profesor, dga y control</b> \n\n\
¡¡En caso de querer eliminar todos esos usuarios del sistema asegurate de haber creado y confirmado una cuenta de usuario con perfil de <b>Administrador</b>!! \n"

	if yad --title "¿Eliminar Usuarios Predefinidos?" --center \
       --text "$TEXTO" \
       --text-align center \
       --window-icon vitalinux-64x \
       --image vitalinux-64x \
       --width=500 \
       --button="Saltar":1 --button="Administrar Cuentas":0 ; then
		sudo -u $(who | grep " :0 " | cut -d" " -f1 | sort -u) /usr/bin/users-admin
	fi

}

function configurar-usuario-inicio-automatico-lightdm {
	echo "--> Se va a configurar como usuario de inicio de sesión a $1 ..."
	USERDEFINITIVO="$1"
	if test "$1" != "usuario-ldap" ; then
		if grep "autologin-user" /etc/lightdm/lightdm.conf &> /dev/null ; then
			sed --follow-symlinks -i "s/.*autologin-user=.*/autologin-user=$1/g" /etc/lightdm/lightdm.conf
		else
			echo "autologin-user=$1" >> /etc/lightdm/lightdm.conf
		fi
	else
# Si el usuario que va a iniciar sesión es de LDAP quitaremos el autologin y esconderemos usuarios locales
	if grep autologin-user /etc/lightdm/lightdm.conf &> /dev/null ; then
		sed --follow-symlinks -i "s/autologin-user=.*/#&/g" /etc/lightdm/lightdm.conf
	fi

	if grep greeter-hide-users /etc/lightdm/lightdm.conf &> /dev/null ; then
		if grep "#greeter-hide-users=" /etc/lightdm/lightdm.conf &> /dev/null ; then
			sed --follow-symlinks -i "s/#greeter-hide-users.*/greeter-hide-users=true/g" /etc/lightdm/lightdm.conf
		else
			sed --follow-symlinks -i "s/greeter-hide-users.*/greeter-hide-users=true/g" /etc/lightdm/lightdm.conf
		fi
	else
		echo "greeter-hide-users=true" >> /etc/lightdm/lightdm.conf
	fi

	fi
}

function crear-usuario {
	TEXTO="$1"

	if DATOS=$(yad --center --width 400 \
	--window-icon vitalinux-64x \
	--image usuario-64x \
	--title "Inicio de Sesión Automático" \
	--text-align center --justify="center" \
	--text "$TEXTO" \
	--form \
	--field="Nombre de Usuario" \
	--field="Password":H \
	--field="Repetir Password":H \
	--field="Comentario" \
	--button="Crear Usuario:0" --button="No Necesito Crear Usuario:1") ; then

		NOMBRE=$(echo $DATOS | cut -d"|" -f1 | tr [:upper:] [:lower:])
		PASS=$(echo $DATOS | cut -d"|" -f2)
		REPPASS=$(echo $DATOS | cut -d"|" -f3)
		COMENTARIO=$(echo $DATOS | cut -d"|" -f4)

		if ! (grep "^$NOMBRE:" /etc/passwd) \
			&& test "$PASS" == "$REPPASS" \
			&& ! (echo "$NOMBRE" | grep " " &> /dev/null) \
			&& useradd -m -d /home/$NOMBRE \
			-s /bin/bash -p $(printf "$PASS" | mkpasswd -s -m md5) \
			-c "$NOMBRE - $COMENTARIO" $NOMBRE ; then

			if yad --center --width 500 \
				--window-icon vitalinux-64x \
				--title "Inicio de Sesión Automático" \
				--text-align center \
				--image usuario-64x \
				--text "   ¿¿Te gustaría que el usuario <b>$NOMBRE</b>   \n    fuera <b>administrador</b> del equipo??   " \
				--button="Si, <b>$NOMBRE</b> Administrador":0 --button="No":1 ; then
				/usr/sbin/usermod -aG adm,cdrom,sudo,dip,plugdev,lpadmin,sambashare $NOMBRE
				return 0
			fi

		else

			yad --center --width 500 \
			--window-icon=/usr/share/lxpanel/images/vitalinux.svg \
			--title "Inicio de Sesión Automático" \
			--text-align center \
			--image=/usr/share/lxpanel/images/usuario.png \
			--text "  Error al crear la cuenta de Usuario ...\n\n  <b>¡¡El nombre no es válido o las contraseñas no coinciden!!</b>" \
			--button="Volver a Crear Usuario":0

	TEXTO="  ¡¡Debes indicar un nombre de usuario y contraseñas válidas!!  \n\
Usuarios Existentes: <b>$USUARIOSEXISTENTES</b> \n\n\
A lo hora de crear un nuevo usuario recuerda tener en cuenta lo siguiente: \n\n\
1.- El nombre del usuario no debe tener espacios en blanco \n\
2.- No se puede usar el nombre de un usuario ya existente en Vitalinux \n\
2.- No utilizes mayúsculas para el nombre \n\
3.- Puedes usar números \n"

			crear-usuario "$TEXTO"

		fi
	else
		return 1
	fi
}

function decidir-usuario-inicio-sesion {
	MENSAJE="$1"
	USUARIO=$(yad --center --width 500 \
	--window-icon vitalinux-64x \
	--title "Inicio de Sesión Automático" \
	--text-align center \
	--image usuario-64x \
	--entry \
	--text "$MENSAJE" \
	--entry-text \
	"Sin-Inicio-Sesion-Automático" \
	"Usuario Nuevo a Crear" \
	$(awk -F ":" '{if ( $3 > 999 && $6~/\/home\/.*/) {print $1}}' /etc/passwd) \
	"Usuario LDAP" \
	--button="Confirmar Selección:0")

	if test "$USUARIO" == "Usuario Nuevo a Crear" ; then
		TEXTO="  ¡¡Ok!! Vamos a <b>crear un nuevo usuario</b> en Vitalinux  \n\n\
  Usuarios Existentes: <b>$USUARIOSEXISTENTES</b> \n\n\
  A lo hora de crear un nuevo usuario recuerda tener en cuenta lo siguiente: \n\n\
   1.- El nombre del usuario no debe tener espacios en blanco \n\
   2.- No se puede usar el nombre de un usuario ya existente en Vitalinux \n\
   3.- No utilizes mayúsculas para el nombre \n\
   4.- Puedes usar números \n"
		if crear-usuario "$TEXTO" ; then
			configurar-usuario-inicio-automatico-lightdm "$USUARIO"
		else
			decidir-usuario-inicio-sesion "$MENSAJE"
		fi
	else
		configurar-usuario-inicio-automatico-lightdm "$USUARIO"
	fi
}

if [ -f $_FIRST ] ; then

	if cat $_FIRST | grep "ENT-CASA" &> /dev/null ; then
		TEXTO="  Como va a hacerse un uso personal o privado de Vitalinux (<i>fuera de un Centro Educativo</i>) se va a crear un usuario <b>Administrador</b> para trabajar con el equipo.  \n\n\
Usuarios Existentes: <b>$USUARIOSEXISTENTES</b> \n\n\
  Deberás tener en cuenta los siguientes aspectos:   \n\n\
   1.- El nombre del usuario no debe tener espacios en blanco \n\
   2.- No se puede usar el nombre de un usuario ya existente en Vitalinux \n\
   3.- No utilizes mayúsculas para el nombre \n\
   4.- Puedes usar números \n"
		crear-usuario "$TEXTO"
		eliminar-usuarios-del-sistema
	fi

	if test "$(cat /etc/lightdm/lightdm.conf | grep 'autologin-user=' | cut -d '=' -f2)" != "" ; then
		decidir-usuario-inicio-sesion "$TEXTO1"
	else
		decidir-usuario-inicio-sesion "$TEXTO2"
	fi

fi
