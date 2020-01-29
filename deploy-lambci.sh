#!/bin/bash

set -e

aws cloudformation deploy --stack-name lambci --template-file ci.template.yaml --parameter-overrides "GithubToken=$GITHUB_TOKEN" "GithubSecret=$GITHUB_SECRET" "SlackToken=$SLACK_TOKEN" --capabilities CAPABILITY_NAMED_IAM
