#!/bin/bash

# Detener el servicio de MySQL (si está en ejecución)
echo "Deteniendo el servicio de MySQL..."
sudo service mysql stop

# Desinstalar MySQL y paquetes relacionados
echo "Desinstalando MySQL..."
sudo apt-get remove --purge mysql-server mysql-client mysql-common -y

# Eliminar archivos de configuración y datos
echo "Eliminando archivos de configuración y datos..."
sudo rm -rf /etc/mysql /var/lib/mysql

# Limpiar paquetes no utilizados
echo "Limpiando paquetes no utilizados..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# Verificar la desinstalación
echo "Verificando la desinstalación..."
if ! command -v mysql &> /dev/null; then
    echo "MySQL ha sido desinstalado correctamente."
else
    echo "Error: MySQL no se ha desinstalado correctamente."
fi