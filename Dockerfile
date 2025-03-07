# Usa una imagen base más ligera y estable
FROM debian:bullseye-slim

# Eliminar la caché de APT y forzar reintentos
RUN rm -rf /var/lib/apt/lists/*

# Forzar timeout para evitar cortes en Railway
RUN timeout 300 apt-get update -o Acquire::Retries=3

# Instalar dependencias necesarias
RUN apt-get install -y unzip wget openjdk-11-jre

# Crear la carpeta de GraphDB
RUN mkdir -p /opt/graphdb

# Descargar y extraer GraphDB Free
RUN wget https://download.ontotext.com/graphdb/GraphDB-Free-10.0.1.zip -O /opt/graphdb.zip && \
    unzip /opt/graphdb.zip -d /opt/ && \
    mv /opt/GraphDB-Free-10.0.1 /opt/graphdb && \
    rm /opt/graphdb.zip

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
