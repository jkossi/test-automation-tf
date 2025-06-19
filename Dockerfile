FROM alpine/ansible:2.18.6

# Install Terraform
ARG PRODUCT=terraform
ARG VERSION=1.12.1

# TODO: install ezcater netskope certs so that we can re-enable cert checks

RUN cd /tmp && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip --no-check-certificate && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS --no-check-certificate && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig --no-check-certificate && \
    grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
    unzip /tmp/terraform_1.12.1_linux_amd64.zip -d /tmp && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    rm -f /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS ${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig

COPY . /app
WORKDIR /app

CMD ./entrypoint.sh