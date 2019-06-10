## Obtenemos las etiquetas/tags de migasfree para que otras aplicaciones puedan usarlas
if ! [ -f $_FIRST ] ; then
    if ETIQUETAS=$(sudo migasfree-tags -g 2> /dev/null) ; then
        echo "${ETIQUETAS}" > /tmp/migasfree.tags
        chmod 644 /tmp/migasfree.tags
    fi
fi