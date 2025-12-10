#!/bin/bash
# Script de Hardening (Seguridad)

echo "--- Aplicando seguridad al sistema ---"

# 1. Configurar Firewall UFW
echo "Configurando reglas de firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp

# Habilitar firewall
echo "y" | sudo ufw enable
echo "Firewall activo."

# 2. Seguridad SSH
echo "Deshabilitando acceso root por SSH..."
ARCHIVO_SSH="/etc/ssh/sshd_config"

sudo cp $ARCHIVO_SSH "$ARCHIVO_SSH.old"
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' $ARCHIVO_SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' $ARCHIVO_SSH
sudo systemctl restart sshd

# 3. Permisos de archivos
echo "Ajustando permisos..."
if [ -f /opt/webapp/docker-compose.yml ]; then
    sudo chmod 600 /opt/webapp/docker-compose.yml
fi
sudo chmod 700 ../maintenance/backup.sh

echo "--- Hardening completado ---"
