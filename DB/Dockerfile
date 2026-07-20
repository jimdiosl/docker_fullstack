FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=sistemas20.
ENV MYSQL_DATABASE=socrud

COPY init.sql /docker-entrypoint-initdb.d/

CMD ["mysqld", "--bind-address=0.0.0.0"]