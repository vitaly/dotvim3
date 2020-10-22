# ruby
bundle

# python
export PYTHONWARNINGS="ignore:DEPRECATION"
pip2 install -r deps/pip2.txt
pip3 install -r deps/pip3.txt

# node
yarn global add $(cat deps/node.txt)
