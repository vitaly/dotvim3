
# src/plugins/10-init/files/deps/install.sh -------------------

set -eEu
set -o pipefail

# src/plugins/20-settings/plugins/interpreters/files/deps/install.sh -------------------

# ruby
bundle

# python
export PYTHONWARNINGS="ignore:DEPRECATION"
pip2 install -r deps/pip2.txt
pip3 install -r deps/pip3.txt

# node
yarn global add $(cat deps/node.txt)

# src/plugins/40-ide/plugins/10-completion/engine/coc/files/deps/install.sh -------------------

# coc extensions
TERM=dumb vim "+echo 'installing COC extensions'" "+CocInstall -sync $(echo `cat deps/coc-extensions.txt`)" "+w ! tee >&2" "+qa!"
