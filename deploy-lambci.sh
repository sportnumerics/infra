#!/bin/bash

set -e

./decrypt.sh
source ./config/env.sh
unset AWS_SESSION_TOKEN

pip install --user awscli

aws cloudformation deploy --stack-name lambci --template-file ci.template.yaml --parameter-overrides "GithubToken=$GITHUB_TOKEN" "GithubSecret=$GITHUB_SECRET" "SlackToken=$SLACK_TOKEN" --capabilities CAPABILITY_NAMED_IAM
