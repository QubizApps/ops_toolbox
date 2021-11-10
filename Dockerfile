ARG alpine_version=3.14
ARG terraform_version=1.0.5

FROM alpine:${alpine_version} AS base-alpine
WORKDIR /app

COPY ./entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]

FROM base-alpine AS aws
WORKDIR /app

RUN apk add --update --no-cache  \
        curl \
        git \
        python3 \
        py3-pip \
    && cd /usr/local/bin \
    && curl https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip \
        -o terraform_${terraform_version}_linux_amd64.zip \
    && unzip terraform_${terraform_version}_linux_amd64.zip \
    && rm terraform_${terraform_version}_linux_amd64.zip \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli \
    && rm -rf /var/cache/apk/*

# Copy configuration
COPY . .

