ARG alpine_version=3.19.1
ARG awscli_version=2.13.25
ARG terraform_version=1.7.5

ARG dir=/app
ARG user=ops

FROM alpine:${alpine_version} AS base-alpine

# Setup
ARG terraform_version

ARG dir
ARG user

# Create user and dir
WORKDIR ${dir}
RUN adduser -D ${user} \
    && chown -R ${user} ${dir}

# Install dependencies
WORKDIR /usr/local/bin
RUN apk add \
    --update \
    --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/ \
    curl~=8.5 \
    && curl https://releases.hashicorp.com/terraform/"${terraform_version}"/terraform_"${terraform_version}"_linux_amd64.zip \
    -o terraform_"${terraform_version}"_linux_amd64.zip \
    && unzip terraform_"${terraform_version}"_linux_amd64.zip \
    && rm terraform_"${terraform_version}"_linux_amd64.zip

# Configure entrypoint
COPY ./entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT ["sh", "/entrypoint"]

FROM base-alpine AS aws-alpine

# Setup
ARG awscli_version

ARG dir
ARG user

# Install dependencies
RUN apk add \
    --update \
    --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/ \
    aws-cli~="${awscli_version}"


# Switch to user and workspace
WORKDIR ${dir}
USER ${user}
