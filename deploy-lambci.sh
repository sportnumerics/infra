#!/bin/bash

set -e

./decrypt.sh
source ./config/env.sh
unset AWS_SESSION_TOKEN

pip install awscli

REPOS="sportnumerics/infra,sportnumerics/stats,sportnumerics/predict,sportnumerics/explorer-api,sportnumerics/explorer"

aws cloudformation deploy --stack-name lambci --template-file ci.template.json --parameter-overrides "Repositories=$REPOS" --capabilities CAPABILITY_NAMED_IAM
