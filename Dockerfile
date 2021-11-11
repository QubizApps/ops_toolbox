ARG alpine_version=3.14
ARG awscli_version=1.22
ARG terraform_version=1.0.5

ARG user=app

FROM alpine:${alpine_version} AS aws-alpine
WORKDIR /usr/local/bin

RUN adduser -D ${user} && chown -R ${user} /${user}

RUN apk add --update --no-cache  \
        curl \
        git \
        python3 \
        py3-pip \
    && curl https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip \
        -o terraform_${terraform_version}_linux_amd64.zip \
    && unzip terraform_${terraform_version}_linux_amd64.zip \
    && rm terraform_${terraform_version}_linux_amd64.zip \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli=${awscli_version}

COPY ./entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

WORKDIR /${user}
USER ${user}

ENTRYPOINT ["/entrypoint"]
