#!/bin/bash

set -e

aws cloudformation deploy --stack-name lambci-ecs --template-file ecs.ci.template.json --capabilities CAPABILITY_NAMED_IAM --parameter-overrides "DesiredInstanceCapacity=0"
