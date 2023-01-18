#!/bin/bash

#set -x       #uncomment this line if you need debug

NAME_OF_THE_BUCKET="blaize-collator-bucket"
PROFILE="blaize"


PROVIDER_LIST=("AWS" "GCP")
WORKSPACE_LIST=("test" "dev" "prod")

for PROVIDER in ${PROVIDER_LIST[@]}; do
  for WORKSPACE in ${WORKSPACE_LIST[@]}; do
    aws s3 cp tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars --profile ${PROFILE}
  done
done
