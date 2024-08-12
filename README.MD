# Proyecto AWS con Terraform y GitHub Actions

Este proyecto despliega una VPN, un bucket S3, una instancia EC2 t2.micro y una tabla DynamoDB en AWS usando Terraform y GitHub Actions. También incluye una página PHP con un "¡Hola Mundo!" en el bucket S3.

## Estructura del Proyecto

- `.github/workflows/terraform.yml`: Configuración de GitHub Actions.
- `main.tf`: Configuración principal de Terraform.
- `variables.tf`: Variables de Terraform.
- `outputs.tf`: Salidas de Terraform.
- `s3/index.php`: Página PHP.
- `README.md`: Instrucciones del proyecto.

## Despliegue

1. Clona el repositorio.
2. Configura tus credenciales de AWS en los secretos de GitHub (`AWS_ACCESS_KEY_ID` y `AWS_SECRET_ACCESS_KEY`).
3. Haz push a la rama `main` para iniciar el despliegue.
