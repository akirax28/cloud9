FROM alpine:3.12
LABEL maintainer "Akirax28"

ENV INSTALL_PATH /app

RUN apk add --update --no-cache \
        bash git nodejs make gcc g++ python3 curl wget build-base \
        openssl-dev apache2-utils libxml2-dev sshfs tmux supervisor npm \
        binutils-gold build-base curl file g++ gcc git less libstdc++ \
        libffi-dev libc-dev linux-headers libxml2-dev libxslt-dev \
        libgcrypt-dev make netcat-openbsd nodejs openssl pkgconfig \
        postgresql-dev python tzdata yarn imagemagick \
    && rm -f /var/cache/apk/* \
    && git clone https://github.com/c9/core.git /c9 \
    && curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
    && mkdir -p $INSTALL_PATH workdir \
    && cd c9\
    && ./scripts/install-sdk.sh

VOLUME ["$INSTALL_PATH"]
WORKDIR $INSTALL_PATH

ENV USERNAME user
ENV PASSWORD pass

ENTRYPOINT ["sh", "-c", "/usr/bin/node /c9/server.js -l 0.0.0.0 -p 8080 -w $INSTALL_PATH -a $USERNAME:$PASSWORD"]
