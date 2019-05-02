FROM node:8

#consul and vault

ENV VAULT_VERSION=1.1.1 \
  CONSUL_VERSION=1.4.4

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  git \
  curl \
  wget \
  vim \
  net-tools \
  iputils-ping \
  dnsutils \
  zip \
  unzip \
  && wget -O /tmp/vault.zip "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" \
  && unzip -d /bin /tmp/vault.zip \
  && chmod 755 /bin/vault \
  && rm /tmp/vault.zip \
  && wget -O /tmp/consul.zip "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" \
  && unzip -d /bin /tmp/consul.zip \
  && chmod 755 /bin/consul \
  && rm /tmp/consul.zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME "/mnt/data"
#CMD ["/bin/bash"]


#consul-template


ENV DOCKER_BASE_VERSION=0.0.4

# This is the location of the releases.
ENV HASHICORP_RELEASES=https://releases.hashicorp.com

# Create a consul-template user and group first so the IDs get set the same way,
# even as the rest of this may change over time.
#RUN addgroup consul-template
RUN adduser  consul-template

# Set up certificates, our base tools, and Consul Template (CT).
RUN # apt add --no-cache ca-certificates curl gnupg libcap openssl && \
    BUILD_GPGKEY=91A6E7F85D05C65630BEF18951852D87348FFC4C; \
    found=''; \
    for server in \
        hkp://p80.pool.sks-keyservers.net:80 \
        hkp://keyserver.ubuntu.com:80 \
        hkp://pgp.mit.edu:80 \
    ; do \
        echo "Fetching GPG key $BUILD_GPGKEY from $server"; \
        gpg --keyserver "$server" --recv-keys "$BUILD_GPGKEY" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $BUILD_GPGKEY" && exit 1; \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip && \
    wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS && \
    wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig && \
    gpg --batch --verify docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig docker-base_${DOCKER_BA  SE_VERSION}_SHA256SUMS && \
    grep ${DOCKER_BASE_VERSION}_linux_amd64.zip docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip && \
    cp bin/gosu bin/dumb-init /bin && \
    cd /tmp && \
    rm -rf /tmp/build && \
#    apt del gnupg openssl && \
    rm -rf /root/.gnupg

# Install consul-template
COPY consul-template /bin

# The agent will be started with /consul-template/config as the configuration directory
# so you can add additional config files in that location.
RUN mkdir -p /consul-template/data && \
    mkdir -p /consul-template/config && \
    chown -R consul-template:consul-template /consul-template

# Expose the consul-template data directory as a volume since that's where
# shared results should be rendered.
#VOLUME /consul-template/data

# The entry point script uses dumb-init as the top-level process to reap any
# zombie processes created by Consul Template sub-processes.
#COPY docker/alpine/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]

# Run consul-template by default
CMD ["/bin/consul-template", "-config " , "data/consul-template.hcl" ]

ADD  entrypoint.sh /bin

# Create app directory
WORKDIR /usr/src/app

#ADD  entrypoint.sh /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

#RUN chmod +x entrypoint.shS

EXPOSE 8080 3000 0200
#CMD [ "consul-tmplate"]
ENTRYPOINT ["./entrypoint.sh"]
#CMD [ "npm", "start","/bin/bash", "&&" ,"/bin/consul-template", "-config " , "/consul-template/config/consul-template.hcl" ]
