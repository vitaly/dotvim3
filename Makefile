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

export PYTHONWARNINGS="ignore:DEPRECATION"

deps/nodejs:
	@[[ -n $$SKIP_NODEJS_DEPS ]] || bash deps/nodejs
.PHONY: deps/nodejs

deps/ruby:
	@[[ -n $$SKIP_RUBY_DEPS ]] || bash deps/ruby
.PHONY: deps/ruby

deps/python2:
	@[[ -n $$SKIP_PYTHON_DEPS || -n $$SKIP_PYTHON2_DEPS ]] || bash deps/python2
.PHONY: deps/python2

deps/python3:
	@[[ -n $$SKIP_PYTHON_DEPS || -n $$SKIP_PYTHON3_DEPS ]] || bash deps/python3
.PHONY: deps/python3

deps: deps/nodejs deps/ruby deps/python2 deps/python3
.PHONY: deps

plugins:
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: plugins

extensions:
	bash deps/coc
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
	bash ./deps/upgrade.sh
	vim +'PlugUpgrade' +'PlugUpdate'
.PHONY: upgrade

build:
	docker build --rm -t vim .
.PHONY: build
