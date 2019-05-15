include .config

DEFAULT ?= configure
default: ${DEFAULT}
.PHONY: default

export VIM_DIR ?= $(shell sh -c pwd)
SRC := cd src &&

configure:
	${SRC} bin/generate.sh
.PHONY: configure

vconfigure:
	${SRC} bin/generate.sh -v
.PHONY: vconfigure

reconfigure:
	${SRC} bin/generate.sh -f
.PHONY: reconfigure

edit: ${VIM_DIR}/.config
	vim ${VIM_DIR}/.config
.PHONY: edit

deps:
	bash deps/install.sh
.PHONY: deps

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
