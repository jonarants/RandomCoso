#!/bin/bash

show_help () {
    echo "Uso: $0 -u <usuario> -d <base_de_datos> -o <archivo_salida>."
    echo "-u Usuario de la base de datos (obligatorio)."
    echo "-d Nombre de la base de datos (obligatorio) "
    echo "-o Ruta y nombre del archivo de respaldo (opcional, por defecto: /tmp/backup.sql)."
    echo "-h Muestra esta ayuda"
    exit 0
}

while getopts ":u:d:o:h" opt; do
    case ${opt} in
    u) db_user="${OPTARG}" ;;
    d) db_name="${OPTARG}" ;;
    o) output_file="${OPTARG}" ;;
    h) show_help ;;
    *) echo "Opción inválida: -$OPTARG">&2; show_help
    esac
done

#Verifica que mysqldump este instalado
if ! command -v mysqldump &> /dev/null; then
    echo "mysqldump no pudo ser encontrado. Por favor instalalo e intenta de nuevo."
    exit 1
fi

# USER INPUT VALIDATION

if [[ -z "$db_user" || -z "$db_name" || -z "$output_file" ]]; then
   echo "Error: Faltan argumentos obligatorios."
   show_help
fi

# READING USER PASSWORD
read -s -p "Introduce la contrasena para el usuario $db_user:" db_password

mysqldump -u "$db_user" -p "$db_password" -d "$db_name" > "$output_file"

echo "🔧 Iniciando respaldo..."
echo "👤 Usuario: $db_user"
echo "💾 Base de datos: $db_name"
echo "📄 Archivo de salida $output_file"

if [ -f "$output_file" ] 
then
    if [ -s "$output_file" ]
    then
    echo "✅ Backup exitoso:$output_file"    
    else
    echo "❌ Falla al realizar el backup"
    fi
else
    echo "❌ Falla al realizar el backup"
fi