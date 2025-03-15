#!/bin/bash

# Actualizar la lista de paquetes
echo "Actualizando la lista de paquetes..."
sudo apt-get update

# Instalar MySQL Server
echo "Instalando MySQL Server..."
sudo apt-get install mysql-server -y

# Iniciar el servicio de MySQL
echo "Iniciando el servicio de MySQL..."
sudo service mysql start

# Solicitar la contraseña para el usuario root de MySQL
read -sp "Introduce la contraseña para el usuario root de MySQL: " MYSQL_ROOT_PASSWORD
echo ""

# Configurar la contraseña del usuario root de MySQL
echo "Configurando la contraseña del usuario root de MySQL..."
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

# Crear la base de datos 'clientes'
echo "Creando la base de datos 'clientes'..."
sudo mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE clientes;"

# Verificar la creación de la base de datos
echo "Verificando la creación de la base de datos..."
sudo mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"

# Verificar el estado del servicio de MySQL
echo "Verificando el estado del servicio de MySQL..."
sudo service mysql status

# Mensaje final
echo "MySQL ha sido instalado y configurado correctamente."
echo "Base de datos 'clientes' creada."
echo "La contraseña del usuario root de MySQL es la que introdujiste anteriormente."
echo "El servicio de MySQL ha sido iniciado."