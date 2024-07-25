ARG POSTGRES_VERSION=15

FROM postgres:${POSTGRES_VERSION}

COPY ./restore.sh /restore.sh
RUN chmod +x /restore.sh

USER postgres

CMD ["/restore.sh"]
