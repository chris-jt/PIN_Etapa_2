# Proyecto AWS con Terraform y GitHub Actions

Este proyecto despliega una VPN, un bucket S3, una instancia EC2 t2.micro y una tabla DynamoDB en AWS usando Terraform y GitHub Actions. También incluye una página PHP con un "¡Hola Mundo!" en el bucket S3.

El archivo main.tf define todos los recursos de AWS:

VPC con una subred pública
Internet Gateway y tabla de rutas
Grupo de seguridad para permitir tráfico web y SSH
Instancia EC2 t2.micro con Debian
Bucket S3 con el ID de la cuenta AWS en el nombre
Tabla DynamoDB llamada "Pages" con los campos requeridos


variables.tf define las variables utilizadas en main.tf
outputs.tf muestra información importante después del despliegue
userdata.sh es un script que se ejecuta al iniciar la instancia EC2 para instalar y configurar Apache y PHP
El archivo de GitHub Actions (deploy.yml) automatiza el despliegue:

Se activa con cada push a la rama main
Configura las credenciales de AWS
Instala Terraform
Ejecuta los comandos de Terraform para desplegar la infraestructura



Para utilizar este proyecto:

Crea un repositorio en GitHub y sube estos archivos.
Configura los secretos en GitHub (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, EC2_KEY_NAME).
Asegúrate de tener un par de claves EC2 creado en AWS y usar su nombre en el secreto EC2_KEY_NAME.
Haz un push a la rama main para activar el despliegue.

Después del despliegue, podrás acceder a la instancia EC2 por SSH y a la página PHP a través de la IP pública de la instancia.

# userdata.sh
El archivo userdata.sh es un script de shell que se utiliza para configurar la instancia EC2 cuando se inicia por primera vez. Es una característica muy útil de AWS que permite automatizar la configuración inicial de una instancia. Vamos a analizar su contenido y cómo se utiliza:
Explicación línea por línea:

#!/bin/bash: Esto indica que el script debe ser ejecutado por el intérprete de Bash.
apt-get update: Actualiza la lista de paquetes disponibles.
apt-get install -y apache2 php libapache2-mod-php: Instala Apache2, PHP y el módulo de PHP para Apache. La opción -y responde automáticamente "sí" a todas las preguntas durante la instalación.
systemctl enable apache2: Configura Apache para que se inicie automáticamente en cada arranque del sistema.
systemctl start apache2: Inicia el servicio de Apache.
echo "<?php echo 'Hola Mundo!'; ?>" > /var/www/html/index.php: Crea un archivo PHP simple con el mensaje "Hola Mundo!" en el directorio raíz de Apache.

Cómo se utiliza:
En el archivo main.tf, el userdata se especifica en la definición del recurso aws_instance:
La función file() de Terraform lee el contenido del archivo userdata.sh y lo pasa como un argumento a la instancia EC2.
Cuando AWS lanza la instancia EC2, ejecuta este script automáticamente como parte del proceso de inicialización. Esto sucede solo una vez, la primera vez que se inicia la instancia.
Beneficios de usar userdata:

    Automatización: Permite configurar la instancia sin necesidad de conectarse manualmente después del lanzamiento.
    Reproducibilidad: Asegura que todas las instancias se configuren de la misma manera.
    Ahorro de tiempo: Reduce significativamente el tiempo necesario para tener una instancia lista para usar.
    Flexibilidad: Puedes personalizar la configuración según tus necesidades específicas.

En este caso, el userdata se utiliza para configurar rápidamente un servidor web con PHP, lo que permite que la página "Hola Mundo!" esté disponible tan pronto como la instancia esté en funcionamiento.

# Eliminacion de la infra
Explicación del workflow de eliminación:

Se activa manualmente con workflow_dispatch.
Configura las credenciales de AWS.
Configura Terraform.
Ejecuta terraform init para inicializar el directorio de trabajo de Terraform.
Ejecuta terraform destroy con la opción -auto-approve para eliminar toda la infraestructura sin necesidad de confirmación manual.

Para utilizar este workflow:

Sube el archivo delete.yml a tu repositorio de GitHub.
Cuando quieras eliminar toda la infraestructura, ve a la pestaña "Actions" en tu repositorio de GitHub.
Selecciona el workflow "Delete AWS Infrastructure".
Haz clic en "Run workflow".

Consideraciones importantes:

Asegúrate de que las credenciales de AWS tengan los permisos necesarios para eliminar todos los recursos.
El comando terraform destroy eliminará todos los recursos definidos en tus archivos de Terraform. Asegúrate de que realmente quieres eliminar todo antes de ejecutar este workflow.
Si tienes recursos que se crearon fuera de Terraform (por ejemplo, manualmente o por otros scripts), estos no serán eliminados por este proceso.
Si tienes recursos con protección contra eliminación (como buckets S3 con versionado habilitado), es posible que necesites desactivar estas protecciones manualmente antes de ejecutar el workflow de eliminación.
Considera añadir una confirmación adicional o un paso de aprobación en el workflow para prevenir eliminaciones accidentales.

Este enfoque te permite mantener la gestión de tu infraestructura con Terraform mientras proporcionas una forma fácil de eliminar todo cuando sea necesario. Recuerda siempre ser cuidadoso al utilizar comandos que pueden eliminar recursos, especialmente en entornos de producción.