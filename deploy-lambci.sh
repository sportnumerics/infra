#!/bin/bash

set -e

./decrypt.sh
source ./config/env.sh
unset AWS_SESSION_TOKEN

pip install --user awscli

REPOS="sportnumerics/infra,sportnumerics/stats,sportnumerics/predict,sportnumerics/explorer-api,sportnumerics/explorer"
LAMBCI_VERSION="0.9.13"

aws cloudformation deploy --stack-name lambci --template-file ci.template.json --parameter-overrides "Repositories=$REPOS" "Version=$LAMBCI_VERSION" --capabilities CAPABILITY_NAMED_IAM
