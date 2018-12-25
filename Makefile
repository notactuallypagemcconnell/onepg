#!/usr/bin/make -f

NAME=notactuallypagemcconnell/onepg
SHELL=/usr/bin/env bash
.PHONY: test all clean build
.DEFAULT_GOAL := build
RUBY_VERSION?="2.5.2"
RUBY_CFLAGS?="$$CFLAGS -fno-omit-frame-pointer -fno-strict-aliasing"
RUBY_CPPFLAGS?="$$CPPFLAGS -fno-omit-frame-pointer -fno-strict-aliasing"

all: build

build:
	docker build --build-arg RUBY_CPPFLAGS=$(RUBY_CPPFLAGS) --build-arg RUBY_CFLAGS=$(RUBY_CFLAGS) --build-arg RUBY_VERSION=$(RUBY_VERSION) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` --build-arg VCS_REF=`git rev-parse --short HEAD` -t $(NAME):latest . 

test:
	speaker-test -t sine -f 5000 -l 1 || echo -ne "\\007"

clean:
	docker rmi -f notactuallypagemcconnell/onepg || echo "You weren't even dirty?"
