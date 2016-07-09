#!/bin/bash

# This script will perform deployment steps specified in the "if" statement.

if ([ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then
    echo "Setting AWS cloudfront preview"
    aws configure set preview.cloudfront true
    echo "Invalidating cloudfront cache."
    aws cloudfront create-invalidation --cli-input-json '{"DistributionId":"'"$AWS_CLOUDFRONT_ID"'","InvalidationBatch":{"Paths":{"Quantity":2,"Items":["/index.html","/*"]},"CallerReference":"'$(date "+%s")'"}}'
else
    echo "Build successful. Pull requests and non-master branch do not publish."
fi
