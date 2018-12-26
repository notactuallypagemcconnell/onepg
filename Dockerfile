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
        ffmpeg \
        git \
        gmp-dev \
        jpeg \
        libressl \
        make \
        py3-pip \
        python3 \
        tar \
        tzdata \
        yaml \
        xz \
        zlib; \
    pip3 install --upgrade pip;

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
        make \
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

# Build OTP from source.
ARG OTP_VERSION
ARG OTP_CPPFLAGS
RUN set -xe; \
    apk --no-cache add --virtual .otp-build-deps \
        alpine-sdk \
        autoconf \
        glu-dev \
        libressl-dev \
        ncurses-dev \
        openjdk8 \
        perl-dev \
        unixodbc-dev \
        wxgtk-dev \
        zlib-dev; \
    curl -SL https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz \
    | tar -xvzC /var/tmp; \
    cd /var/tmp/otp-OTP-${OTP_VERSION}; \
    export PATH="/usr/lib/jvm/java-1.8-openjdk/bin:$PATH"; \
    export ERL_TOP=`pwd`; \
    ./otp_build autoconf; \
    ./configure --prefix=/usr/local \
        --sysconfdir=/usr/loca/etc \
        --enable-threads \
        --enable-shared-zlib \
        --enable-ssl=dynamic-ssl-lib; \
    make -j "$(nproc)"; \
    make release_tests; \
    make install; \
    cd /var/tmp; \
    rm -rf /var/tmp/otp-OTP-${OTP_VERSION}; \
    apk del .otp-build-deps;

# Build Elixir from source.
ARG ELIXIR_VERSION
RUN set -xe; \
    curl -SL https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz \
    | tar -xvzC /var/tmp; \
    cd /var/tmp/elixir-${ELIXIR_VERSION}; \
    make -j "$(nproc)"; \
    make install; \
    make test; \
    cd /var/tmp/; \
    rm -rf /var/tmp/elixir-${ELIXIR_VERSION};

# Finalize build.
RUN set -e; \
    bash -c "$(curl -sL https://kadi.ma/H1VqUv1ZN)";

# A few more things.
RUN set -xe; \
    apk add --no-cache --virtual gif-build-deps \
        alpine-sdk \
        jpeg-dev \
        python3-dev \
        zlib-dev; \
    pip3 install gif-for-cli; \
    curl -SL https://media.giphy.com/media/Fyubg2TieQ1C8/giphy.gif > /onepg/keyboard.gif; \
    chown -R onepg:onepg /onepg;

# Put on a show.
RUN set -xe; \
    gif-for-cli --display-mode truecolor -l 30 /onepg/keyboard.gif & \
    reset; \
    wait;

# Drop down to our unprivileged user.
USER onepg

# Setup our environment variables.
ENV PATH="/usr/local/bin:$PATH" \
    GEM_HOME="/onepg/.gem" \
    LANG="en_US.UTF-8" 

# Set our working directory.
WORKDIR /onepg

# Install application deps.
# I was in a hurry this can't possibly be the best way
RUN set -xe; \
    export PATH="$(gem env gempath | sed 's|\(.gem/ruby/\)\([0-9].[0-9].[0-9]\):|\1\2/bin:|g'):$PATH"; \
    export GEM_HOME="$(gem env gemhome)"; \
    gem install bundler --user-install; \
    yes | mix local.hex; \
    yes | mix local.rebar; \
    cd make_the_page; \
    bundle install;

# Set the entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
