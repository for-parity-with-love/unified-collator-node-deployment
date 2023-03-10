#!/bin/bash

PROFILE="collator"

#uncomment for debug purpose
#set -x
#export TF_LOG="TRACE"

#if no need debug the uncomment this one
export TF_LOG="ERROR"

#increase  parallelism (performance). If your terraform get stuck or crash then need to reduce number of parallels
export TFE_PARALLELISM=75


WORKSPACE_LIST=("astar" "moonbeam" "karura" "Quit")
PS3="Please select desired collator to destroy: "
            select WORKSPACE in "${WORKSPACE_LIST[@]}"
            do
                case $WORKSPACE in
                    "astar")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        cd ..
                        TERRAFORM_COMMAND=$(terraform workspace list | grep ${WORKSPACE})
                        if [[ -z "${TERRAFORM_COMMAND}" ]]; then
                          terraform workspace new ${WORKSPACE}
                        else
                          terraform workspace select ${WORKSPACE}
                        fi
                        cat examples/deployments/${WORKSPACE}-deployment.example > collator.tf
                        echo "terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars"
                        terraform workspace select ${WORKSPACE}
                        terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars
                        echo "terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars"
                        exit
                        ;;
                    "moonbeam")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        cd ..
                        TERRAFORM_COMMAND=$(terraform workspace list | grep ${WORKSPACE})
                        if [[ -z "${TERRAFORM_COMMAND}" ]]; then
                          terraform workspace new ${WORKSPACE}
                        else
                          terraform workspace select ${WORKSPACE}
                        fi
                        cat examples/deployments/${WORKSPACE}-deployment.example > collator.tf
                        echo "terraform destroy -var-file tfvars/${WORKSPACE}.tfvars"
                        terraform workspace select ${WORKSPACE}
                        terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars
                        echo "terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars"
                        exit
                        ;;
                    "karura")
                        echo "${WORKSPACE} was chosen..."
                        echo 'making setup...'
                        cd ..
                        TERRAFORM_COMMAND=$(terraform workspace list | grep ${WORKSPACE})
                        if [[ -z "${TERRAFORM_COMMAND}" ]]; then
                          terraform workspace new ${WORKSPACE}
                        else
                          terraform workspace select ${WORKSPACE}
                        fi
                        cat examples/deployments/${WORKSPACE}-deployment.example > collator.tf
                        echo "terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars"
                        aws s3 cp s3://${NAME_OF_THE_BUCKET}/terraform/tfvars/${WORKSPACE}.tfvars tfvars/${WORKSPACE}.tfvars --profile ${PROFILE}
                        terraform workspace select ${WORKSPACE}
                        terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars
                        echo "terraform destroy -var-file examples/tfvars/${WORKSPACE}.tfvars"
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
