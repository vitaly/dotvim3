include .config

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

deps/nodejs:
	bash deps/nodejs
.PHONY: deps/nodejs

deps/ruby:
	bash deps/ruby
.PHONY: deps/ruby

export PYTHONWARNINGS="ignore:DEPRECATION"

deps/python2:
	bash deps/python2
.PHONY: deps/python2

deps/python3:
	bash deps/python3
.PHONY: deps/python3

deps/coc:
	bash deps/coc
.PHONY: deps/coc

deps: deps/nodejs deps/ruby deps/python2 deps/python3
.PHONY: deps

extensions: deps/coc
.PHONY: extensions

install:
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: install

update:
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: update

# TODO: generate list by make configure
GENERATED := $(shell cat src/plugins/00-cleanup/lists/managed-files)

clean:
	rm -f ${GENERATED}
.PHONY: clean

clean-bundle:
	rm -rf bundle/*
.PHONY: clean-bundle

clean-all: clean clean-bundle
.PHONY: clean-all

upgrade:
	bash ./deps/upgrade.sh
	vim +'PlugUpgrade' +'PlugUpdate'
.PHONY: upgrade

build:
	docker build --rm -t vim .
.PHONY: build
