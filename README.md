# Proyecto de Infraestructura - TechSolutions
**Alumno:** Francisco Ossio


Este repositorio contiene la suite de automatización desarrollada en Bash para el aprovisionamiento, endurecimiento y respaldo de un servidor web seguro basado en contenedores Docker.

## 1. Guía de Despliegue

Para desplegar la infraestructura correctamente, siga este orden estricto de ejecución en una terminal con acceso a internet:

1.  **Clonar el repositorio:**
    Descargue el proyecto en su máquina local.

2.  **Módulo 1: Aprovisionamiento (Setup)**
    Este script instala Docker, crea la estructura de carpetas y genera el sitio web.
    ```bash
    cd deploy
    sudo chmod +x setup.sh
    sudo ./setup.sh
    # Una vez finalizado, levante el contenedor:
    sudo docker-compose up -d
    ```

3.  **Módulo 2: Seguridad (Hardening)**
    Este script aplica las reglas de firewall y asegura el servicio SSH.
    ```bash
    cd ../security
    sudo chmod +x hardening.sh
    sudo ./hardening.sh
    ```

4.  **Módulo 3: Mantenimiento (Backup)**
    Este script genera una copia de seguridad y simula su transferencia remota.
    ```bash
    cd ../maintenance
    sudo chmod +x backup.sh
    sudo ./backup.sh
    ```

---

## 2. Justificación de Seguridad

En este proyecto se han aplicado principios fundamentales de ciberseguridad para proteger la integridad del servidor.

En primer lugar, se ha **deshabilitado el acceso directo del usuario 'root' a través de SSH** (`PermitRootLogin no`). Esta medida es crítica porque el usuario 'root' es el objetivo estándar de la mayoría de los ataques automatizados de fuerza bruta y diccionarios. Al prohibir su acceso directo, obligamos a cualquier atacante a adivinar primero un nombre de usuario válido y luego su contraseña, añadiendo una capa significativa de complejidad. Además, esto fuerza a los administradores legítimos a iniciar sesión con usuarios nominales, lo que mejora la trazabilidad y la auditoría de las acciones realizadas en el sistema (accountability).

En segundo lugar, la implementación del **Firewall UFW** bajo una política de "Denegación por Defecto" (*Default Deny Incoming*) es esencial para reducir la superficie de ataque. Un servidor recién instalado puede tener servicios innecesarios escuchando en puertos abiertos. Al bloquear todo el tráfico entrante y permitir explícitamente solo el puerto 22 (gestión) y el 8080 (servicio web), garantizamos que incluso si un servicio vulnerable se ejecuta accidentalmente, no será accesible desde el exterior, cumpliendo así con el principio de Defensa en Profundidad.

---

## 3. Registro de Evidencia

Las capturas de pantalla que certifican el funcionamiento de los módulos se encuentran en la carpeta `evidence/`:

* **ufw_status.png:** Muestra la tabla de reglas del firewall activa, permitiendo solo tráfico TCP en puertos 22 y 8080.
* **web_access.png:** Evidencia del navegador web mostrando el archivo `index.html` servido por el contenedor con el nombre del alumno.
* **ssh_config.png:** Verificación del archivo de configuración SSH donde se observa la directiva `PermitRootLogin` establecida en `no`.
