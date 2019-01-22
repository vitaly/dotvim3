export VIM_DIR ?= ${PWD}

SRC := cd src &&

default: install
.PHONY: default

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

install: configure
	chmod +x ./deps/install.sh
	./deps/install.sh
	vim +PlugInstall +UpdateRemotePlugins +qa
.PHONY: install

update: configure
	vim +PlugInstall +UpdateRemotePlugins +qa
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
	./deps/upgrade.sh
	vim +'PlugUpgrade' +'PlugUpdate'
.PHONY: upgrade
