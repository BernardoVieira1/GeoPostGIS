# Use a imagem oficial do PostgreSQL
FROM postgres:latest

# Instale o PostGIS
RUN apt-get update && apt-get install -y postgis postgresql-12-postgis-3

# Copie o script de inicialização
COPY init.sql /docker-entrypoint-initdb.d/

# Exponha a porta do PostgreSQL
EXPOSE 5432
