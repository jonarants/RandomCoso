#!/bin/bash
# Funcion donde se muestra la ayuda
show_help () {
    echo "Uso: $0 -u <usuario> -d <base_de_datos> -o <archivo_salida>."
    echo "-u Usuario de la base de datos (obligatorio)."
    echo "-d Nombre de la base de datos (obligatorio) "
    echo "-o Ruta y nombre del archivo de respaldo (opcional, por defecto: /tmp/backup.sql)."
    echo "-h Muestra esta ayuda"
    exit 0
}
# Se toman los parametros del usuario
while getopts ":u:d:o:h" opt; do
    case ${opt} in
    u) db_user="${OPTARG}" ;;
    d) db_name="${OPTARG}" ;;
    o) output_file="${OPTARG}" ;;
    h) show_help ;;
    *) echo "Opción inválida: -$OPTARG">&2; show_help
    esac
done
# Se comprueba si mysqldump está instalado y se informa al usuario de un error si este no esta instalado.
if ! command -v mysqldump &> /dev/null; then
    echo "mysqldump no pudo ser encontrado. Por favor instalalo e intenta de nuevo."
    exit 1
fi
# Validación de las entradas del usuario
if [[ -z "$db_user" || -z "$db_name" ]]; then
   echo "Error: Faltan argumentos obligatorios ."
   show_help
fi
# Se valida si existe un path absoluto, si no existe, se usa /tmp/backup.sql
if [[ -z "$output_file" ]]; then
	echo "Se usara el valor por default para hacer el respalado /tmp/backup.sql"
	output_file="/tmp/backup.sql"
fi
# Se lee la contraseña del usuario
read -s -p "Introduce la contrasena para el usuario $db_user: " db_password
echo ""
# Ejecutar mysqldump de manera segura con variable de entorno y eliminar la información
MYSQL_PWD="$db_password" mysqldump -u "$db_user" "$db_name" > "$output_file"
echo "Limpiando variables de entorno y contraseña..."
unset MYSQL_PWD db_password
echo "Se ha limpiado la información de las contraseñas del usuario"
# Se imprime información para el usuario
echo "🔧 Iniciando respaldo..."
echo "👤 Usuario: $db_user"
echo "💾 Base de datos: $db_name"
echo "📄 Archivo de salida $output_file"
# Se verifica si el backup existe en el path
if [ -f "$output_file" ] 
then
# Si el archivo existe, se verifica si su tamaño sea mayor que 0 bytes     
    if [ -s "$output_file" ]
    then
        # Se imprime un mensaje de exito si el archivo existe y su tamaño > que 0
        echo "✅ Backup exitoso:$output_file"
    else
        # Si el archivo esta vacío, se muestra mensaje de falla y se sale
        echo "❌ Falla al realizar el backup (archivo vacío)"
	    exit 1
    fi
else
    # Si el archivo no existe, se muestra mensaje de falla y se sale
    echo "❌ Falla al realizar el backup (archivo no creado)"
	exit 1
fi