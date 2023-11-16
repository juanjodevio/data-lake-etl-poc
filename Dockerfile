FROM python:3.9.18-slim-bullseye

# System setup
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

WORKDIR /usr/app/dbt/
ENTRYPOINT ["dbt"]

COPY ./data_lake_etl_poc .

RUN python -m pip install --no-cache -r requirements.txt