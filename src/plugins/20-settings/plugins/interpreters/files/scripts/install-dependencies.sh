if [[ -z ${DOTVIM_SKIP_NODEJS_DEPS:-} ]]; then
  yarn global add $(cat deps/nodejs.txt)
fi

if [[ -z ${DOTVIM_SKIP_PYTHON_DEPS:-} ]]; then
  ${DOTVIM_PYTHON_PIP:-pip} install --upgrade -r deps/python.txt
fi

if [[ -z ${DOTVIM_SKIP_RUBY_DEPS:-} ]]; then
  bundle
fi
