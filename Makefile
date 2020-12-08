include .config

ifneq (,$(wildcard ./.env))
  include .env
endif

DEFAULT ?= configure
default: ${DEFAULT}
.PHONY: default

GENERATE_OPTS ?=

docs:
	${MAKE} -C docs update
.PHONY: docs

generate:
	src/bin/dotvim ${GENERATE_OPTS}
.PHONY: generate

configure: generate docs
.PHONY: configure

vconfigure: GENERATE_OPTS=-v
vconfigure: generate docs
.PHONY: vconfigure

reconfigure: GENERATE_OPTS=-f
reconfigure: generate docs
.PHONY: reconfigure

edit: .config
	vim .config
.PHONY: edit

export PYTHONWARNINGS="ignore:DEPRECATION"

deps:
ifeq (${DOTVIM_SKIP_DEPS},)
	@test -e ./scripts/install-dependencies.sh && bash ./scripts/install-dependencies.sh
endif
.PHONY: deps

plugins:
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: plugins

extensions:
	@test -e ./scripts/install-extensions.sh && bash ./scripts/install-extensions.sh
.PHONY: extensions

install: deps plugins extensions
.PHONY: install

update:
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: update

GENERATED := $(shell cat .files)
clean:
	rm -f ${GENERATED}
.PHONY: clean

clean-bundle:
	rm -rf bundle/*
.PHONY: clean-bundle

clean-all: clean clean-bundle
.PHONY: clean-all

upgrade:
	vim +'PlugUpgrade' +'PlugUpdate'
.PHONY: upgrade

build:
	docker build --rm -t vim .
.PHONY: build
