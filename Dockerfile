FROM nvidia/cuda:9.0-devel-ubuntu16.04 as ccminer-tpruvot-builder
LABEL maintainer="skinlayers@gmail.com"

ARG GIT_URL=https://github.com/tpruvot/ccminer.git
ARG GIT_BRANCH=linux
ARG GIT_COMMIT_HASH=07859f93cef68072d8011f3f9a60d443ae11289e
ARG BUILD_DEPENDENCIES=" \
        automake \
        autotools-dev \
        build-essential \
        git \
        libcurl4-openssl-dev \
        libssl-dev \
        libjansson-dev \
"

RUN set -eux && \
    apt-get update && apt-get -y install $BUILD_DEPENDENCIES && \
    git clone -b "$GIT_BRANCH" --single-branch "$GIT_URL" && \
    cd ccminer && \
    git reset --hard $GIT_COMMIT_HASH && \
    grep -Eq '^nvcc_ARCH.*-gencode=arch=compute_61,code=\\"sm_61,compute_61\\"$' Makefile.am || \
    sed -i '/^#nvcc_ARCH.*-gencode=arch=compute_61,code=\\"sm_61,compute_61\\"$/a nvcc_ARCH += -gencode=arch=compute_61,code=\\"sm_61,compute_61\\"' Makefile.am && \
    ./autogen.sh && \
    ./configure && \
    make -j $(nproc) && \
    make install

FROM nvidia/cuda:9.0-base-ubuntu16.04
LABEL maintainer="skinlayers@gmail.com"

ARG RUNTIME_DEPENDENCIES=" \
        libcurl3 \
        libgomp1 \
        libjansson4 \
"

RUN set -eux && \
    adduser --system --home /data --group ccminer && \
    apt-get update && apt-get -y install \
        $RUNTIME_DEPENDENCIES --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

COPY --from=ccminer-tpruvot-builder /usr/local/bin/ccminer /usr/local/bin
COPY ./docker-entrypoint.sh /

RUN chmod 0755 /docker-entrypoint.sh

USER ccminer

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/ccminer"]
