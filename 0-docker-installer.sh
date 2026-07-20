#!/bin/bash

# Este script debe ejecutarse con 'sudo bash instalar_docker.sh' o 'chmod +x instalar_docker.sh' y luego './instalar_docker.sh'

if [ "$EUID" -ne 0 ]
  then echo "⚠️  Por favor, ejecuta este script con sudo (e.g., sudo bash $0)"
  exit 1
fi

echo "--- 1. Limpiando instalaciones antiguas de Docker (si las hay) ---"
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt remove $pkg -y; done

echo "--- 2. Preparando el sistema e instalando dependencias ---"
apt update
apt install ca-certificates curl gnupg lsb-release -y

echo "--- 3. Agregando la clave GPG de Docker (Método moderno) ---"
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "--- 4. Configurando el repositorio para Ubuntu 22.04 (jammy) ---"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "--- 5. Instalando Docker Engine, CLI y Docker Compose (plugin) ---"
apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "--- 6. Verificando el estado del servicio Docker ---"
systemctl status docker --no-pager

# Usamos 'SUDO_USER' para obtener el nombre del usuario original, no 'root'
TARGET_USER=${SUDO_USER:-$(whoami)}

echo "--- 7. Solucionando problema de permisos: Agregando el usuario ${TARGET_USER} al grupo 'docker' ---"
usermod -aG docker ${TARGET_USER}

echo " "
echo "✅ Instalación de Docker y Docker Compose V2 completada."
echo "****************************************************************"
echo "⚠️  ACCIÓN FINAL NECESARIA:"
echo "El usuario **${TARGET_USER}** ya fue añadido al grupo 'docker'."
echo "Para poder ejecutar comandos como 'docker run hello-world' **sin usar 'sudo'**,"
echo "debes hacer una de las siguientes acciones:"
echo "   1. **CERRAR LA SESIÓN** y volver a iniciarla."
echo "   2. Ejecutar el comando: **newgrp docker**"
echo "****************************************************************"