# Usa una imagen base más ligera para evitar errores en Railway
FROM debian:bullseye-slim

# Eliminar la caché de APT para evitar problemas de bloqueo
RUN rm -rf /var/lib/apt/lists/*

# Forzar timeout y reintentos en apt-get update para evitar cancelaciones
RUN timeout 300 apt-get update -o Acquire::Retries=3

# Instalar dependencias necesarias
RUN apt-get install -y unzip wget openjdk-11-jre

# Crear la carpeta de GraphDB
RUN mkdir -p /opt/graphdb

# Copiar GraphDB desde GitHub en lugar de descargarlo
COPY GraphDB-Free-10.X.X /opt/graphdb

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
