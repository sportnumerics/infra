#!/bin/bash

set -e

AS_GROUP_NAME=$(aws cloudformation describe-stacks --stack-name lambci --query 'Stacks[0].Outputs[?OutputKey==`AutoScalingGroupName`].OutputValue' --output text)

aws autoscaling update-auto-scaling-group --auto-scaling-group-name $AS_GROUP_NAME --desired-capacity 1
