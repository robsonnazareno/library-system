FROM postgres:latest

ENV POSTGRES_DB=librarydb
ENV POSTGRES_USER=user
ENV POSTGRES_PASSWORD=root

COPY migrations/* /docker-entrypoint-initdb.d/

EXPOSE 5432