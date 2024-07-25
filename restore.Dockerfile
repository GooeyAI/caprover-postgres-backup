ARG POSTGRES_VERSION=15

FROM postgres:${POSTGRES_VERSION}

RUN apt-get update && apt-get install -y curl

USER postgres

# install gcloud sdk
#
RUN curl -s https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz \
    | tar xz && ./google-cloud-sdk/install.sh -q --usage-reporting=false
ENV PATH=$PATH:google-cloud-sdk/bin/

COPY ./restore.sh /tmp/restore.sh
RUN chmod +x /tmp/restore.sh

CMD ["/tmp/restore.sh"]
