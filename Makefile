include .config

DEFAULT ?= configure
default: ${DEFAULT}
.PHONY: default

export VIM_DIR ?= $(shell /bin/pwd  -P)
SRC := cd src &&

GENERATE_OPTS ?=

generate:
	${SRC} bin/generate.sh ${GENERATE_OPTS}
.PHONY: generate

configure: generate
.PHONY: configure

vconfigure: GENERATE_OPTS=-v
vconfigure: generate
.PHONY: vconfigure

reconfigure: GENERATE_OPTS=-f
reconfigure: generate
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
