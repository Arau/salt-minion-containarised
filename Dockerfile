FROM ubuntu:jammy-20240111

# https://github.com/saltstack/salt/releases
ENV SALT_VERSION="3006.6"
ENV SALT_BUILD_DIR="/etc/docker-salt/build" \
    SALT_HOME="/home/salt"


RUN mkdir -p ${SALT_BUILD_DIR}
WORKDIR ${SALT_BUILD_DIR}

# Install packages
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install --yes --quiet --no-install-recommends \
      sudo \
      ca-certificates \
      apt-transport-https \
      wget \
      locales \
      tzdata \
 && DEBIAN_FRONTEND=noninteractive update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
    locale-gen en_US.UTF-8 \
    dpkg-reconfigure locales \
 && DEBIAN_FRONTEND=noninteractive apt-get clean --yes \
 && rm -rf /var/lib/apt/lists/*

# Install saltstack
COPY assets/build ${SALT_BUILD_DIR}
RUN bash ${SALT_BUILD_DIR}/install.sh

# Entrypoint
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh

RUN mkdir -p "${SALT_HOME}"
WORKDIR ${SALT_HOME}

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
