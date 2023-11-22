FROM ubuntu:22.04

COPY C2_* /tmp/
ENV C2_PLUGINDIR=/usr/local/plugins
ENV C2_LIBDIR=/usr/local/lib
RUN apt-get update && \
    apt-get install -y git make gcc && \
    mkdir -p /opt /usr/local/lib /usr/local/plugins && \
    cd /usr/local && \
    git clone https://github.com/c2lang/c2_libs lib && \
    cd lib && \
    git reset --hard $(cat /tmp/C2_LIBS_COMMIT_HASH) && \
    rm -rf .git && \
    cd /opt && \
    git clone https://github.com/c2lang/c2c_native && \
    cd c2c_native && \
    git reset --hard $(cat /tmp/C2_NATIVE_COMMIT_HASH) && \
    make -C bootstrap && \
    ./install_plugins.sh && \
    cp -p output/c2c/c2c output/c2tags/c2tags /usr/local/bin/ && \
    cd / && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /opt/c2c_native /var/lib/apt/lists/*
