#!/bin/bash

set -e

STACK_NAME=lambci

aws cloudformation deploy --stack-name $STACK_NAME --template-file ci.template.yaml --capabilities CAPABILITY_NAMED_IAM --no-fail-on-empty-changeset

AUTOSCALING_GROUP_NAME=$(
  aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].Outputs[?OutputKey==`AutoScalingGroupName`].OutputValue' \
    --output text
  )

CLUSTER=$(
  aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].Outputs[?OutputKey==`Cluster`].OutputValue' \
    --output text
  )

TASK=$(
  aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].Outputs[?OutputKey==`Task`].OutputValue' \
    --output text
  )

DOCKER_PROJECTS=( "gh/sportnumerics/stats" "gh/sportnumerics/explorer" "gh/sportnumerics/predict" )

for PROJECT in "${DOCKER_PROJECTS[@]}"
do
  echo "Updating configuration for $PROJECT"
  lambci config --project $PROJECT docker.autoscalingGroup $AUTOSCALING_GROUP_NAME
  lambci config --project $PROJECT docker.cluster $CLUSTER
  lambci config --project $PROJECT docker.task $TASK
  lambci config --project $PROJECT docker.runArgs "-v /var/run/docker.sock:/var/run/docker.sock --ulimit nofile=262144:262144"
done

lambci config secretEnv.AWS_DEFAULT_REGION "us-east-1"