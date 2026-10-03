# terraform-aws
Basics for terraform in AWS

## Instalación de Terraform

### Windows
1. Descarga Terraform desde [terraform.io/downloads](https://www.terraform.io/downloads)
2. Descomprime el archivo ZIP
3. Mueve el ejecutable `terraform.exe` a una carpeta en tu PATH (ej: `C:\Program Files\Terraform`)
4. Verifica la instalación:
   ```bash
   terraform --version
   ```

### macOS (Homebrew)
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Linux
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## Comandos Fundamentales de Terraform

### Inicialización
```bash
terraform init
```
- Descarga los providers necesarios
- Inicializa el backend de estado
- Debe ejecutarse en cada nuevo directorio de trabajo

### Formatear el código
```bash
terraform fmt
```
- Formatea los archivos .tf de acuerdo a las convenciones de Terraform
- Recomendado antes de hacer commits

### Validar la configuración
```bash
terraform validate
```
- Verifica la sintaxis y validez de la configuración
- No accede a servicios remotos

### Planificación
```bash
terraform plan
```
- Muestra los cambios que se realizarán
- Útil para revisar antes de aplicar cambios
- Opciones útiles:
  - `terraform plan -out=tfplan`: Guarda el plan en un archivo
  - `terraform plan -var="region=us-west-2": Pasa variables

### Aplicar cambios
```bash
terraform apply
```
- Ejecuta los cambios planificados
- Solicita confirmación antes de aplicar
- Opciones útiles:
  - `terraform apply -auto-approve`: Aplica sin confirmación (no recomendado en producción)
  - `terraform apply tfplan`: Aplica un plan guardado

### Destruir recursos
```bash
terraform destroy
```
- Elimina todos los recursos creados por Terraform
- Solicita confirmación antes de destruir
- Opciones útiles:
  - `terraform destroy -auto-approve`: Destruye sin confirmación

### Mostrar estado
```bash
terraform show
```
- Muestra el estado actual de los recursos
- Útil para debugging y ver detalles de los recursos

### Salida de variables
```bash
terraform output
```
- Muestra los valores de las variables de salida definidas
- Útil para obtener información como IPs, ARNs, etc.

### Importar recursos existentes
```bash
terraform import aws_instance.example i-1234567890abcdef0
```
- Importa recursos existentes a Terraform
- Útil cuando se empieza a usar Terraform en infraestructura existente

### Limpiar caché
```bash
terraform clean
```
- Elimina la caché local de providers y módulos
- Útil cuando hay problemas de dependencias

## Autenticación con AWS

Terraform puede autenticarse con AWS de varias formas:

### 1. Variables de entorno (Recomendado)
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Archivo de credenciales
Configura `~/.aws/credentials`:
```
[default]
aws_access_key_id = your_access_key
aws_secret_access_key = your_secret_key
```

### 3. Perfiles de AWS
```bash
aws configure --profile myprofile
```
Luego en Terraform:
```hcl
provider "aws" {
  region  = "us-east-1"
  profile = "myprofile"
}
```

## Estructura del Proyecto

- `1-basics/`: Ejemplos básicos de recursos de AWS
- `2-variables/`: Uso de variables y outputs
- `3-functions/`: Funciones de Terraform
- `4-modules/`: Creación y uso de módulos
- `5-structure/`: Estructura avanzada con workspaces
