if ! pip3 list | grep tasklib; then
  pip3 install git+git://github.com/robgolding63/tasklib@develop
fi

if ! pip3 list | grep six; then
  pip3 install six
fi
