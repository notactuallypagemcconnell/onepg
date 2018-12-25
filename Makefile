#!/usr/bin/make -f

NAME=notactuallypagemcconnell/onepg
SHELL=/usr/bin/env bash
.PHONY: test all clean build
.DEFAULT_GOAL := build
RUBY_VERSION?="2.5.2"
RUBY_CFLAGS?="$$CFLAGS -fno-omit-frame-pointer -fno-strict-aliasing"
RUBY_CPPFLAGS?="$$CPPFLAGS -fno-omit-frame-pointer -fno-strict-aliasing"
OTP_VERSION?="20.3.8.15"
OTP_CPPFLAGS?="-D_BSD_SOURCE $$CPPFLAGS"
ELIXIR_VERSION?="1.7.4"

all: build

build:
	docker build --build-arg ELIXIR_VERSION=$(ELIXIR_VERSION) --build-arg OTP_VERSION=$(OTP_VERSION) --build-arg RUBY_CPPFLAGS=$(RUBY_CPPFLAGS) --build-arg RUBY_CFLAGS=$(RUBY_CFLAGS) --build-arg RUBY_VERSION=$(RUBY_VERSION) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` --build-arg VCS_REF=`git rev-parse --short HEAD` -t $(NAME):latest . 

# We can use build_dev to bypass adding meta data and 
# take advantage of cache
build_dev:
	docker build --build-arg ELIXIR_VERSION=$(ELIXIR_VERSION) --build-arg OTP_VERSION=$(OTP_VERSION)  --build-arg RUBY_CPPFLAGS=$(RUBY_CPPFLAGS) --build-arg RUBY_CFLAGS=$(RUBY_CFLAGS) --build-arg RUBY_VERSION=$(RUBY_VERSION) -t $(NAME):latest . 

test:
	speaker-test -t sine -f 5000 -l 1 || echo -ne "\\007"

# This is a terrible way to clean an image
clean:
	docker rmi -f notactuallypagemcconnell/onepg || echo "You weren't even dirty?"
