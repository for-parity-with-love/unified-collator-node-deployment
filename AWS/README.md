# infrastructure by Terraform

### Pre-requirments
1) You need to create IAM user with programmatic access (full administrator access) and then fill and then fill credentials to `~/.aws/credentials` file, eg.:

```commandline
[blaize]
aws_access_key_id = KEYKEYKEYKEYKEYKEYKEYKEYKEY
aws_secret_access_key = KEYKEYKEYKEYKEYKEYKEYKEYKEY
```

2) Then you should create a bucket because we will store your state and tfvars (file with variables) in bucket.
after it would be done, you will need to edit `deploy.sh` and `upload-tfvars.sh` scripts and fill `NAME_OF_THE_BUCKET` and `PROFILE` variables

3) Open tfvar file and edit these variables
```
aws_region                          = "eu-central-1"
aws_profile_name                    = "blaize" 
```


### Usage

- If you need to deploy then use `bash deploy.sh` script.
- If you need to upload then use `bash upload-tfvars.sh` script.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->