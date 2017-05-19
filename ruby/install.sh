#!/bin/bash

rbenv init
git clone https://github.com/garnieretienne/rvm-download.git ~/.rbenv/plugins/rvm-download

mkdir -p ~/.rbenv/plugins
git clone git://github.com/tpope/rbenv-communal-gems.git ~/.rbenv/plugins/rbenv-communal-gems
rbenv communize --all