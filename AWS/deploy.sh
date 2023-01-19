#!/bin/bash
set -e

NAME_OF_THE_BUCKET="blaize-collator-bucket"
PROFILE="blaize"


#uncomment for debug purpose
#set -x
#export TF_LOG="TRACE"

#if no need debug the uncomment this one
export TF_LOG="ERROR"

#increase  parallelism (performance). If your terraform get stuck or crash then need ti reduce number of parallels
export TFE_PARALLELISM=75


PROVIDER_LIST=("AWS" "GCP" "Quit")
WORKSPACE_LIST=("test" "dev" "prod" "Quit")
PS3="Please select cloud provider in what you are interested in: "
select PROVIDER in "${PROVIDER_LIST[@]}"
do
    case ${PROVIDER} in
        "AWS")
            PS3="Please select workspace of ${PROVIDER} project to deploy: "
            select WORKSPACE in "${WORKSPACE_LIST[@]}"
            do
                case $WORKSPACE in
                    "test")
                        echo "${WORKSPACE} workspace of ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER} backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                             cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                             terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "dev")
                        echo "${WORKSPACE} workspace in ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER}  backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                            cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                           terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "prod")
                        echo "${WORKSPACE} workspace in ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER}  backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                            cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                            terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "Quit")
                        break
                        ;;
                    *)
                        echo "invalid option ${REPLY}"
                        ;;
                esac
              done
            exit
            ;;
        "GCP")
            PS3="Please select workspace of ${PROVIDER} project to deploy: "
            select WORKSPACE in "${WORKSPACE_LIST[@]}"
            do
                case $WORKSPACE in
                    "test")
                        echo "${WORKSPACE} workspace of ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER}  backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                             cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                             terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "dev")
                        echo "${WORKSPACE} workspace in ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER}  backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                            cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                           terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "prod")
                        echo "${WORKSPACE} workspace in ${PROVIDER} project was chosen"
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        echo 'making setup...'
                        if grep -q ${PROVIDER}  backend.tf
                        then
                            #found
                            sleep 0.1
                        else
                            #not found
                            cat backend/${PROVIDER}-backend.tmp | tee backend.tf > /dev/null 2>&1
                            terraform init -reconfigure
                        fi
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${PROVIDER}/${WORKSPACE}-collator.tfvars tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars --profile ${PROVIDER}-mfa
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars"
                        exit
                        ;;
                    "Quit")
                        break
                        ;;
                    *)
                        echo "invalid option ${REPLY}"
                        ;;
                esac
              done
            exit
            ;;
        "Quit")
            break
            ;;
        *)
            echo "invalid option ${REPLY}"
            ;;
    esac
done
