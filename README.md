
# Script de Respaldo de Base de Datos MySQL

Este script realiza un respaldo de una base de datos MySQL utilizando `mysqldump`. Permite al usuario especificar el nombre de usuario de la base de datos, el nombre de la base de datos a respaldar y la ruta de salida del archivo de respaldo. Si no se proporciona una ruta de salida, el archivo se guardará en `/tmp/backup.sql` de forma predeterminada.

## Requisitos

- `mysqldump` debe estar instalado en el sistema.
- El usuario debe tener permisos adecuados para realizar un respaldo de la base de datos.

## Uso

```bash
./backup.sh -u <usuario> -d <base_de_datos> -o <archivo_salida>
```

### Opciones

- `-u <usuario>`: El usuario de la base de datos (obligatorio).
- `-d <base_de_datos>`: El nombre de la base de datos que se desea respaldar (obligatorio).
- `-o <archivo_salida>`: Ruta y nombre del archivo de respaldo. Si no se proporciona, se utilizará `/tmp/backup.sql` como predeterminado (opcional).
- `-h`: Muestra la ayuda y la descripción del uso del script.

## Funcionamiento

1. **Validación de Dependencias**: El script verifica si `mysqldump` está instalado en el sistema. Si no está disponible, muestra un mensaje de error y termina la ejecución.
2. **Entrada de Usuario**: El script solicita al usuario la contraseña del usuario de la base de datos y asegura que los argumentos obligatorios (`-u` y `-d`) sean proporcionados.
3. **Generación del Respaldo**: Se ejecuta el comando `mysqldump` para generar el respaldo de la base de datos especificada.
4. **Verificación**: Una vez generado el archivo de respaldo, se verifica si el archivo existe y si tiene un tamaño mayor a cero. Si todo es correcto, el respaldo se considera exitoso. En caso contrario, se muestra un mensaje de error.

## Ejemplo de uso

Para respaldar la base de datos `mi_base_de_datos` con el usuario `admin` y guardar el archivo en `/home/usuario/respaldo.sql`, usa el siguiente comando:

```bash
./backup.sh -u admin -d mi_base_de_datos -o /home/usuario/respaldo.sql
```

Si prefieres utilizar la ruta predeterminada para el archivo de salida, simplemente omite la opción `-o`:

```bash
./backup.sh -u admin -d mi_base_de_datos
```

## Seguridad

El script solicita la contraseña del usuario de la base de datos de manera segura y elimina las variables sensibles una vez completada la tarea.

## Consideraciones

- Asegúrate de tener espacio suficiente en el directorio de salida para el archivo de respaldo.
- El script no realizará una validación avanzada de la contraseña ni la integridad de la base de datos.


