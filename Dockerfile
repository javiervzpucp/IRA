# Usa una imagen ligera
FROM debian:bullseye-slim

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y unzip wget python3 python3-pip

# Instalar gdown para descargar desde Google Drive
RUN pip3 install gdown

# Crear la carpeta de destino
RUN mkdir -p /opt/graphdb

# Descargar la carpeta descomprimida desde Google Drive
RUN gdown --folder --id 1uQc5YS8QPJJScKQ7ynBFZ7_vQiwtFI8E -O /opt/graphdb

# Expone el puerto de GraphDB
EXPOSE 7200

# Copia los archivos de configuración
COPY config.ttl /opt/graphdb/config.ttl
COPY repository.ttl /opt/graphdb/repository.ttl
COPY start.sh /opt/graphdb/start.sh

# Dar permisos de ejecución al script de inicio
RUN chmod +x /opt/graphdb/start.sh

# Comando para iniciar GraphDB
CMD ["/opt/graphdb/start.sh"]

