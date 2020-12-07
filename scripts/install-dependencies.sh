
# src/plugins/20-settings/plugins/interpreters/files/scripts/install-dependencies.sh -------------------

if [[ -z ${DOTVIM_SKIP_RUBY_DEPS:-} ]]; then
  yarn global add $(cat deps/node.txt)
fi

if [[ -z ${DOTVIM_SKIP_PYTHON_DEPS:-} ]]; then
  ${DOTVIM_PYTHON_PIP:-pip} install --upgrade -r deps/pip.txt
fi

if [[ -z ${DOTVIM_SKIP_NODEJS_DEPS:-} ]]; then
  bundle
fi
