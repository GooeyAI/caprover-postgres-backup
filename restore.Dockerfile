ARG POSTGRES_VERSION=15

FROM postgres:${POSTGRES_VERSION}

RUN apt-get update && apt-get install -y curl python3

WORKDIR /tmp

COPY ./restore.sh ./restore.sh

RUN chmod 0777 ./restore.sh
RUN mkdir -p $PGDATA
RUN chown -R postgres:postgres $PGDATA

USER postgres

# install gcloud sdk
#
RUN curl -s https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz \
    | tar xz && ./google-cloud-sdk/install.sh -q --usage-reporting=false
ENV PATH=$PATH:google-cloud-sdk/bin/

CMD ["./restore.sh"]
