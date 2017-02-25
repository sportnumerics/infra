#!/bin/bash

set -e

REPOS="sportnumerics/stats,sportnumerics/predict,sportnumerics/explorer-api,sportnumerics/explorer"

aws cloudformation deploy --stack-name lambci --template-file ci.template.json --parameter-overrides "Repositories=$REPOS" --capabilities CAPABILITY_NAMED_IAM
