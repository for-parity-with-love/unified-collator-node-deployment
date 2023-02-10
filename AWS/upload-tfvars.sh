#!/bin/bash

#set -x       #uncomment this line if you need debug

NAME_OF_THE_BUCKET="blaize-collator-bucket"
PROFILE="blaize"


PROVIDER_LIST=("AWS" "GCP")
WORKSPACE_LIST=("astar" "moonbeam" "subsocial")

for WORKSPACE in ${WORKSPACE_LIST[@]}; do
  aws s3 cp tfvars/${WORKSPACE}.tfvars s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
done
