FROM alpine:3.8

# Build arguments.
ARG VCS_REF
ARG BUILD_DATE
ARG LANG="en_US.UTF-8"

# Labels / Metadata.
LABEL maintainer="James Brink, james.brink@kadima.services" \
    decription="This is the thing I use to make http://bobbyis.me" \
    version="${APACHE_DS_VERSION}" \
    org.label-schema.name="onepg" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/notactuallypagemcconnell/onepg" \
    org.label-schema.schema-version="1.0.0-rc1"

# Create our group & user.
RUN set -xe; \
    addgroup -g 1000 -S onepg; \
    adduser -u 1000 -S -h /onepg -s /bin/sh -G onepg onepg;

# Inspire confidence
RUN set -e; \
    echo -e "\
    Here We GO!!!!\n\
    ░░░░░░░░░░░░░░▄▄▄▄▄▄▄▄▄▄▄▄░░░░░░░░░░░░░░ \n\
    ░░░░░░░░░░░░▄████████████████▄░░░░░░░░░░ \n\
    ░░░░░░░░░░▄██▀░░░░░░░▀▀████████▄░░░░░░░░ \n\
    ░░░░░░░░░▄█▀░░░░░░░░░░░░░▀▀██████▄░░░░░░ \n\
    ░░░░░░░░░███▄░░░░░░░░░░░░░░░▀██████░░░░░ \n\
    ░░░░░░░░▄░░▀▀█░░░░░░░░░░░░░░░░██████░░░░ \n\
    ░░░░░░░█▄██▀▄░░░░░▄███▄▄░░░░░░███████░░░ \n\
    ░░░░░░▄▀▀▀██▀░░░░░▄▄▄░░▀█░░░░█████████░░ \n\
    ░░░░░▄▀░░░░▄▀░▄░░█▄██▀▄░░░░░██████████░░ \n\
    ░░░░░█░░░░▀░░░█░░░▀▀▀▀▀░░░░░██████████▄░ \n\
    ░░░░░░░▄█▄░░░░░▄░░░░░░░░░░░░██████████▀░ \n\
    ░░░░░░█▀░░░░▀▀░░░░░░░░░░░░░███▀███████░░ \n\
    ░░░▄▄░▀░▄░░░░░░░░░░░░░░░░░░▀░░░██████░░░ \n\
    ██████░░█▄█▀░▄░░██░░░░░░░░░░░█▄█████▀░░░ \n\
    ██████░░░▀████▀░▀░░░░░░░░░░░▄▀█████████▄ \n\
    ██████░░░░░░░░░░░░░░░░░░░░▀▄████████████ \n\
    ██████░░▄░░░░░░░░░░░░░▄░░░██████████████ \n\
    ██████░░░░░░░░░░░░░▄█▀░░▄███████████████ \n\
    ███████▄▄░░░░░░░░░▀░░░▄▀▄███████████████ \n\
    " 1>&2;

# Install runtime deps.
RUN set -xe; \
    apk --update add --no-cache --virtual .runtime-deps \
        bash \
        ca-certificates \
        curl \
        gmp-dev \
        tar \
        tzdata \
        xz;

# Copy our assets into the container.
COPY --chown=onepg:onepg ./docker-assets /

# Build ruby from source
ARG RUBY_VERSION
ARG RUBY_CFLAGS
ARG RUBY_CPPFLAGS
RUN set -xe; \
    apk --no-cache add --virtual .ruby-build-deps \
        alpine-sdk \
        autoconf \
        bison \
        coreutils \
        db-dev \
        gdbm-dev \
        libffi-dev \
        libressl-dev \
        linux-headers \
        readline-dev \
        yaml-dev \
        zlib-dev; \
    curl https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-${RUBY_VERSION}.tar.gz \
    | tar -xvzC /var/tmp; \
    cd /var/tmp/ruby-${RUBY_VERSION}; \
    rm tool/config.sub tool/config.guess; \
    cp /usr/share/abuild/config.guess tool/config.guess; \
    cp /usr/share/abuild/config.sub tool/config.sub; \
    autoconf; \
    patch thread_pthread.c /usr/local/patches/ruby/stack.patch; \
    ./configure \
        --prefix=/usr/local \
        --enable-pthread \
        --sysconfdir="/usr/local/etc" \
        --with-sitedir="/usr/local/lib/site_ruby" \
        --with-search-path="/usr/local/lib/site_ruby/${RUBY_VERSION}/$(arch)-linux" \
        --enable-shared \
        --disable-rpath; \
    make -j"$(nrpoc)"; \
    echo "When tests fail, just change the test ¯\_(ツ)_/¯" \
    sed -i 's/\(x = once\)\((128)\)\(; x = once(7); x = once(16);\)/\1(32)\3/g' bootstraptest/test_insns.rb; \
    make test; \
    make install; \
    cd /var/tmp; \
    rm -rf /var/tmp/ruby-${RUBY_VERSION}; \
    apk del .ruby-build-deps;

# Setup our environment variables.
ENV PATH="/usr/local/bin:$PATH" \
    LANG="en_US.UTF-8" 

# Drop down to our unprivileged user.
USER onepg

# Set our working directory.
WORKDIR /onepg

# Set the entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
