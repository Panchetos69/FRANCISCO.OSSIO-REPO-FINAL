#!/bin/bash
# Script de instalacion y despliegue
# Alumno: Francisco Ossio

# Variables
RUTA_APP="/opt/webapp"
URL_REPO="https://gist.githubusercontent.com/DarkestAbed/0c1cee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml"
USUARIO="sysadmin"

echo "--- Iniciando configuracion del servidor ---"

# 1. Instalar paquetes necesarios
echo "Actualizando e instalando programas..."
sudo apt-get update
sudo apt-get install -y git curl ufw docker.io docker-compose

# 2. Crear carpetas
echo "Creando carpetas en $RUTA_APP..."
sudo mkdir -p "$RUTA_APP/html"

# 3. Descargar docker-compose
echo "Descargando archivo docker-compose..."
sudo curl -L "$URL_REPO" -o "$RUTA_APP/docker-compose.yml"

# 4. Crear el index.html
echo "Generando sitio web de prueba..."
# ¡CAMBIA TU NOMBRE AQUI!:
echo "<h1>Servidor Seguro Propiedad de Francisco Ossio - Acceso Restringido</h1>" | sudo tee "$RUTA_APP/html/index.html"

# 5. Crear usuario sysadmin
echo "Configurando usuario $USUARIO..."
if grep -q "$USUARIO" /etc/passwd; then
    echo "El usuario ya existe."
else
    sudo useradd -m -s /bin/bash "$USUARIO"
    sudo usermod -aG docker "$USUARIO"
    echo "Usuario creado correctamente."
fi

echo "--- Setup terminado ---"
