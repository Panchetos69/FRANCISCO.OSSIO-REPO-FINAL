#!/bin/bash
# Script de respaldo

FECHA=$(date +"%Y-%m-%d_%H%M")
ORIGEN="/opt/webapp/html"
DESTINO_LOCAL="/var/backups/webapp"
NOMBRE_ARCHIVO="backup_web_$FECHA.tar.gz"

# Datos ficticios
IP_REMOTO="192.168.1.50"
USER_REMOTO="admin_backup"
RUTA_REMOTA="/home/admin_backup/"

echo "Iniciando respaldo: $FECHA"

# 1. Comprimir
tar -czvf "/tmp/$NOMBRE_ARCHIVO" -C "$ORIGEN" .

# 2. Copia local
sudo mkdir -p "$DESTINO_LOCAL"
sudo rsync -av "/tmp/$NOMBRE_ARCHIVO" "$DESTINO_LOCAL/"

# 3. Copia remota (simulada)
echo "Intentando enviar a servidor remoto..."
scp -o ConnectTimeout=5 "/tmp/$NOMBRE_ARCHIVO" "$USER_REMOTO@$IP_REMOTO:$RUTA_REMOTA"

if [ $? -eq 0 ]; then
    echo "Copia remota exitosa."
else
    echo "Aviso: No se pudo conectar al servidor remoto (Esperado en entorno de prueba)."
fi

rm "/tmp/$NOMBRE_ARCHIVO"
echo "Proceso finalizado."
