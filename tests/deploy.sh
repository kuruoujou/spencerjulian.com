#!/bin/bash

# This script will perform deployment steps specified in the "if" statement.

if ([ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then
    echo "Build successful. De"
    echo "No publish steps yet available. Publish was successful."
else
    echo "Build successful. Pull requests and non-master branch do not publish."
fi
