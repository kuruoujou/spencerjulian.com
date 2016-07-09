#!/bin/bash

# This script will perform deployment steps specified in the "if" statement.

if ([ $TRAVIS_BRANCH == "master" ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then
    echo "Build successful. Pushing to AWS..."
    aws --version
    echo "Make sure credentials are valid."
    aws iam get-user
    echo "Make sure _site directory exists and has files."
    ls _site
    echo "Attempting to push _site to S3 bucket ${AWS_S3_BUCKET} in region ${AWS_REGION}"
    aws s3 sync --region $AWS_REGION --acl public-read --delete _site/ s3://$AWS_S3_BUCKET
    echo "Setting AWS cloudfront preview"
    aws configure set preview.cloudfront true
    echo "Invalidating cloudfront cache."
    aws cloudfront create-invalidation --cli-input-json '{"DistributionId":"'"$AWS_CLOUDFRONT_ID"'","InvalidationBatch":{"Paths":{"Quantity":2,"Items":["/index.html","/*"]},"CallerReference":"'$(date "+%s")'"}}'
else
    echo "Build successful. Pull requests and non-master branch do not publish."
fi
