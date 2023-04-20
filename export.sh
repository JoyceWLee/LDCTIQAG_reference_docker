#!/usr/bin/env bash

./build.sh

docker save iqaregression | gzip -c > IQARegression.tar.gz
