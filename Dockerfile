# Usa una imagen de Ubuntu
FROM ubuntu:latest

# Instala dependencias necesarias
RUN apt update && apt install -y unzip wget openjdk-11-jre

# Descarga GraphDB Free
RUN wget https://download.ontotext.com/graphdb/GraphDB-Free-10.0.1.zip && \
    unzip GraphDB-Free-10.0.1.zip && \
    mv GraphDB-Free-10.0.1 /opt/graphdb

# Expone el puerto 7200 para GraphDB
EXPOSE 7200

# Copia los archivos de configuración
COPY config.ttl /opt/graphdb/config.ttl
COPY repository.ttl /opt/graphdb/repository.ttl
COPY start.sh /opt/graphdb/start.sh

# Da permisos de ejecución al script de inicio
RUN chmod +x /opt/graphdb/start.sh

# Comando para iniciar GraphDB
CMD ["/opt/graphdb/start.sh"]
