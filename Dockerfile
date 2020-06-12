FROM alpine:3.12
LABEL maintainer "Akirax28"

RUN apk add --update --no-cache bash git nodejs make gcc g++ python curl wget build-base openssl-dev apache2-utils libxml2-dev sshfs tmux supervisor npm
RUN rm -f /var/cache/apk/*
RUN git clone https://github.com/c9/core.git /c9
RUN curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash
RUN mkdir -p /workspace
RUN cd /c9
RUN ./scripts/install-sdk.sh

VOLUME ["/workspace"]
WORKDIR /workspace

ENV USERNAME user
ENV PASSWORD pass

ENTRYPOINT ["sh", "-c", "/usr/bin/node /c9/server.js -l 0.0.0.0 -p 8080 -w /workspace -a $USERNAME:$PASSWORD"]
