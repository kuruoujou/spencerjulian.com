#!/bin/bash

# This script will perform deployment steps specified in the "if" statement.

if ([ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then
    echo "Build successful. Invalidating Cloudfront..."
    aws --version
    aws s3 sync --region $AWS_REGION --acl public-read --delete _site/ s3://$AWS_S3_BUCKET
    echo -e "\n[preview]\ncloudfront = true" >> ~/.aws/config
    cat ~/.aws/config
    aws cloudfront create-invalidation --cli-input-json '{"DistributionId":"'"$AWS_CLOUDFRONT_ID"'","InvalidationBatch":{"Paths":{"Quantity":2,"Items":["/index.html","/*"]},"CallerReference":"'$(date "+%s")'"}}'
else
    echo "Build successful. Pull requests and non-master branch do not publish."
fi
