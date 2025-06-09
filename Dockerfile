FROM alpine/ansible:2.18.6

# Install Terraform
ARG PRODUCT=terraform
ARG VERSION=1.12.1

# TODO: install ezcater netskope certs so that we can re-enable cert checks

RUN apk add --update --virtual .deps --no-cache gnupg && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_amd64.zip --no-check-certificate && \
    wget https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_SHA256SUMS --no-check-certificate && \
    wget https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_SHA256SUMS.sig --no-check-certificate && \
    wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt --no-check-certificate | gpg --import && \
    gpg --verify terraform_1.12.1_SHA256SUMS.sig terraform_1.12.1_SHA256SUMS && \
    grep terraform_1.12.1_linux_amd64.zip terraform_1.12.1_SHA256SUMS | sha256sum -c && \
    unzip /tmp/terraform_1.12.1_linux_amd64.zip -d /tmp && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    rm -f /tmp/terraform_1.12.1_linux_amd64.zip terraform_1.12.1_SHA256SUMS 1.12.1/terraform_1.12.1_SHA256SUMS.sig && \
    apk del .deps

COPY . /app
WORKDIR /app

CMD ./entrypoint.sh