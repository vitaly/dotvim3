include .config

ifneq (,$(wildcard ./.env))
  include .env
endif

DEFAULT ?= configure
default: ${DEFAULT}
.PHONY: default

help: # This Target
	@echo "GENERATE_OPTS = ${GENERATE_OPTS}"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n\n  make \033[36m<target>\033[0m\n\n"} /^[a-zA-Z_\/%$${}.-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
.PHONY: help


GENERATE_OPTS ?=

##@ SETUP

configure: ## generate vim files according to config
	src/bin/dotvim ${GENERATE_OPTS}
	${MAKE} -C docs update
.PHONY: configure

vconfigure: GENERATE_OPTS=-v
vconfigure: configure ## configure with -v for verbose
.PHONY: vconfigure

reconfigure: GENERATE_OPTS=-f
reconfigure: configure ## reconfigure with -f to ignore previous answers
.PHONY: reconfigure

edit: .config ## edit .config file
	vim .config
.PHONY: edit

export PYTHONWARNINGS="ignore:DEPRECATION"

##@ INSTALL

deps: ## install dependencies
ifeq (${DOTVIM_SKIP_DEPS},)
	@test -e ./scripts/install-dependencies.sh && bash ./scripts/install-dependencies.sh
endif
.PHONY: deps

plugins: ## install plugins
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: plugins

update: ## update plugins
	VIMRC_SKIP_AFTER_CONFIGS=y vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: update

upgrade: ## upgrade VimPlug
	vim +'PlugUpgrade' +'PlugUpdate'
.PHONY: upgrade

extensions: ## install extensions
	@test -e ./scripts/install-extensions.sh && bash ./scripts/install-extensions.sh
.PHONY: extensions

install: deps plugins extensions ## install dependencies, plugins, and extensions
.PHONY: install

##@ CLEANUP

GENERATED := $(shell cat .files)
clean: ## remove all files generated files by configure
	rm -f ${GENERATED}
.PHONY: clean

clean-bundle: ## remove all installed plugins
	rm -rf bundle/*
.PHONY: clean-bundle

clean-all: clean clean-bundle ## remove all configured files and installed plugins
.PHONY: clean-all

##@ DOCKER

build: ## Build a docker image 'dotvim'
	docker build --rm -t dotvim .
.PHONY: build
