FROM opengisch/qgis-server:3.28.4-jammy

RUN apt-get -y update && \
    apt-get --no-install-recommends --no-install-suggests --allow-unauthenticated -y install \
        less \
        openssh-server \
        python3-pip \
        postgresql-client \
        curl \
        binutils \
        sqlite3 \
        proj-data \
        htop \
        gnupg \
        ca-certificates \
        wget \
        locales \
        spawn-fcgi \
        xauth \
        xvfb \
        gnupg \
        wget && \
    rm -rf /var/lib/apt/lists/* && \
    # link proj file to be right spelled (char case issue)
    ln -s /usr/share/proj/CHENYX06a.gsb /usr/share/proj/CHENyx06a.gsb && \
    mkdir -p /io/plugins && \
    mkdir -p /io/data

RUN useradd -m qgis

ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ./start.sh /usr/local/bin/start.sh

ENTRYPOINT ["/tini", "-p", "SIGTERM", "-g", "--"]

CMD ["/usr/local/bin/start.sh"]

