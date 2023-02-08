#!/bin/bash
set -e

NAME_OF_THE_BUCKET="blaize-collator-bucket"
PROFILE="blaize"

PROVIDER="AWS"
#uncomment for debug purpose
#set -x
#export TF_LOG="TRACE"

#if no need debug the uncomment this one
export TF_LOG="ERROR"

#increase  parallelism (performance). If your terraform get stuck or crash then need to reduce number of parallels
export TFE_PARALLELISM=75


WORKSPACE_LIST=("astar" "moonbeam" "subsocial" "Quit")
PS3="Please select desired collator to deploy: "
            select WORKSPACE in "${WORKSPACE_LIST[@]}"
            do
                case $WORKSPACE in
                    "astar")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${WORKSPACE}.tfvars
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
                        exit
                        ;;
                    "moonbeam")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
                        exit
                        ;;
                    "subsocial")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
                        terraform workspace select ${WORKSPACE}
                        terraform apply -var-file tfvars/${PROVIDER}-${WORKSPACE}-collator.tfvars
                        echo "terraform apply -var-file tfvars/${WORKSPACE}.tfvars"
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
