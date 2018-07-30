export VIM_DIR ?= ${PWD}

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

install: configure
	vim +'PlugInstall' +qa
.PHONY: install

# TODO: generate list by make configure
GENERATED := README.md after/plugin/after.vim autoload/plug.vim colors/buttercream.vim colors/colorzone.vim ftplugin/gitcommit.vim ftplugin/javascript.vim ftplugin/vim.vim gvimrc.after gvimrc.plugins vimrc vimrc.after vimrc.plugins

clean-generated:
	rm -f ${GENERATED}
.PHONY: clean-generated

clean-bundle:
	rm -rf bundle/*
.PHONY: clean-bundle

clean-all: clean-generated clean-bundle
.PHONY: clean-all

update:
	vim +'PlugUpdate'
.PHONY: update

upgrade:
	vim +'PlugUpgrade'
.PHONY: upgrade

# YCM_DIR = ${VIM_DIR}/dein/repos/github.com/Valloric/YouCompleteMe

# ${YCM_DIR}:
	# mkdir -p ${VIM_DIR}/dein/repos/github.com/Valloric
	# cd ${VIM_DIR}/dein/repos/github.com/Valloric
	# git clone https://github.com/Valloric/YouCompleteMe.git YouCompleteMe

# ycm-git: ${YCM_DIR}
	# cd $< && git submodule update --init --recursive

# ycm-install: ycm-git
	# cd ${YCM_DIR} && ./install.py --clang-completer --tern-completer

# completion: ycm-install

# .PHONY: ycm-git ycm-install completion
