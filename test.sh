#!/bin/sh -ex

cd chainer
python setup.py develop install --user

if [ $CUDNN = none ]; then
  nosetests --processes=4 --process-timeout=10000 --with-coverage --cover-branches --cover-package=chainer,cupy -a '!cudnn'
else
  nosetests --processes=4 --process-timeout=10000 --with-coverage --cover-branches --cover-package=chainer,cupy
fi

flake8
coverage xml -i

if [ $COVERALLS_REPO_TOKEN ]; then
  coveralls
fi
