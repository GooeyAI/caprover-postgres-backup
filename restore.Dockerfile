ARG POSTGRES_VERSION=15

FROM postgres:${POSTGRES_VERSION}

RUN apt-get update && apt-get install -y curl python3

USER postgres

WORKDIR /tmp

# install gcloud sdk
#
RUN curl -s https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz \
    | tar xz && ./google-cloud-sdk/install.sh -q --usage-reporting=false
ENV PATH=$PATH:google-cloud-sdk/bin/

COPY ./restore.sh ./restore.sh
RUN chmod +x ./restore.sh

CMD ["./restore.sh"]
