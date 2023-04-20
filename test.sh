#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

./build.sh

docker volume create iqaregression-output

docker run --rm --gpus all \
        --memory=16g \
        -v $SCRIPTPATH/test/:/input/images/synthetic-ct/ \
        -v iqaregression-output:/output/ \
        iqaregression

docker run --rm \
        -v iqaregression-output:/output/ \
        python:3.7-slim cat /output/image-quality-scores.json | python -m json.tool

docker run --rm \
        -v iqaregression-output:/output/ \
        -v $SCRIPTPATH/test/:/input/images/synthetic-ct/ \
        python:3.7-slim python -c "import json, sys; f1 = json.load(open('/output/image-quality-scores.json')); f2 = json.load(open('/input/images/synthetic-ct/expected_output.json')); sys.exit(f1 != f2);"

if [ $? -eq 0 ]; then
    echo "Tests successfully passed..."
else
    echo "Expected output was not found..."
fi

docker volume rm iqaregression-output
