#!/bin/bash

# uncomment this line if you need debug
# set -x

NAME_OF_THE_BUCKET="collator-bucket"
PROFILE="collator"


PROVIDER_LIST=("AWS" "GCP")
WORKSPACE_LIST=("astar" "moonbeam" "karura")

for WORKSPACE in ${WORKSPACE_LIST[@]}; do
  aws s3 cp tfvars/${WORKSPACE}.tfvars s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
done
