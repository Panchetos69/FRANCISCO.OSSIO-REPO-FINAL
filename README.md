# Proyecto Infraestructura TechSolutions
**Alumno:** Francisco Ossio

Automatización para desplegar un servidor web seguro con Nginx y Docker.

## Instrucciones

1.  **Setup:**
    ```bash
    cd deploy
    sudo chmod +x setup.sh
    sudo ./setup.sh
    sudo docker-compose up -d
    ```

2.  **Seguridad:**
    ```bash
    cd ../security
    sudo chmod +x hardening.sh
    sudo ./hardening.sh
    ```

3.  **Respaldo:**
    ```bash
    cd ../maintenance
    sudo chmod +x backup.sh
    sudo ./backup.sh
    ```

## Justificación de Seguridad

* **SSH (PermitRootLogin no):** Deshabilitar el acceso directo de root evita ataques de fuerza bruta al usuario administrador principal, obligando a usar usuarios con menos privilegios.
* **Firewall (UFW):** Al bloquear todo el tráfico entrante excepto puertos 22 y 8080, reducimos la superficie de ataque, protegiendo el servidor de accesos no autorizados a otros servicios.
