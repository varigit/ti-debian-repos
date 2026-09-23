ARG DEB_SUITE=trixie

FROM debian:${DEB_SUITE}-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        devscripts \
        debhelper \
        dpkg-dev \
        equivs \
        ca-certificates \
        git \
        && \
    apt-get clean

RUN git config --system --add safe.directory '/work/*' && \
    git config --system --add safe.directory /work

WORKDIR /work

CMD ["/bin/bash"]
