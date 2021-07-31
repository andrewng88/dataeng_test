#Pull down the latest Postgres image from the Docker Hub
FROM postgres

#Set the environment variable for password to 'docker'
ENV POSTGRES_PASSWORD docker

#Create a database, let's call it 'dbase'
ENV POSTGRES_DB dbase

#Use a sql dump file to create the table schema etc
COPY create_table.sql /docker-entrypoint-initdb.d/