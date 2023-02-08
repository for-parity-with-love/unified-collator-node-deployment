# AWS infrastructure

### Pre-requirments
1) AWS cli with configured access. 
2) Open **EC2** => **Key Pairs** and add your ssh key and after it edit **ec2.tf** file and change **ssh_key_pair** value. 
3) a. Create a bucket to store your state and tfvars (file with variables) there.
   b. Edit `deploy.sh` and `upload-tfvars.sh` scripts and fill `NAME_OF_THE_BUCKET` and `PROFILE` variables. (Name of the profile can be find in `~/.aws/credentials`)

4) Open tfvars file located in tfvars directory and edit these variables
```
aws_region                          = "eu-central-1"
aws_profile_name                    = "blaize" 
```


### Usage
- After each edit tfvars do not forget use `bash upload-tfvars.sh` to upload trfars file to bucket.
- If you need to deploy then use `bash deploy.sh` script.



<!-- BEGIN_TF_DOCS -->