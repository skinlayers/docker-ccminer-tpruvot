FROM nvidia/cuda:9.0-devel-ubuntu16.04 as ccminer-tpruvot-builder
LABEL maintainer="skinlayers@gmail.com"

ENV GIT_URL https://github.com/tpruvot/ccminer.git
ENV BRANCH linux
ENV COMMIT_HASH 3761774ccfe63ace4ef4764cb4dea596b0702ec9

RUN set -eux && \
    ADDITIONAL_BUILD_DEPENDENCIES=" \
        automake \
        autotools-dev \
        build-essential \
        git \
        libcurl4-openssl-dev \
        libssl-dev \
        libjansson-dev \
    "; \
    apt-get update && apt-get -y install $ADDITIONAL_BUILD_DEPENDENCIES && \
    git clone -b "$BRANCH" --single-branch "$GIT_URL" && \
    cd ccminer && \
    git reset --hard $COMMIT_HASH && \
    grep -Eq '^nvcc_ARCH.*-gencode=arch=compute_61,code=\\"sm_61,compute_61\\"$' Makefile.am || \
    sed -i '/^#nvcc_ARCH.*-gencode=arch=compute_61,code=\\"sm_61,compute_61\\"$/a nvcc_ARCH += -gencode=arch=compute_61,code=\\"sm_61,compute_61\\"' Makefile.am && \
    ./autogen.sh && \
    ./configure && \
    make -j $(nproc) && \
    make install

FROM nvidia/cuda:9.0-base-ubuntu16.04
LABEL maintainer="skinlayers@gmail.com"

RUN set -eux && \
    ADDITIONAL_RUNTIME_DEPENDENCIES=" \
        libcurl3 \
        libgomp1 \
        libjansson4 \
    "; \
    adduser --system --home /data --group ccminer && \
    apt-get update && apt-get -y install \
        $ADDITIONAL_RUNTIME_DEPENDENCIES --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

COPY --from=ccminer-tpruvot-builder /usr/local/bin/ccminer /usr/local/bin
COPY ./docker-entrypoint.sh /

RUN chmod 0755 /docker-entrypoint.sh

USER ccminer

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/ccminer"]
