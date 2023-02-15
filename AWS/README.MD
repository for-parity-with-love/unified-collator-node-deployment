# AWS infrastructure

### Pre-requirments
1) Installed AWS cli with configured access. 
2) Created S3 bucket
3) Installed kubectl (optional for interacting with EKS)

### Configurations
1) Edit `deploy.sh`, `destroy.sh` and `upload-tfvars.sh` scripts and fill `NAME_OF_THE_BUCKET` and `PROFILE` variables. (Name of the profile can be find in `~/.aws/credentials` after configuration aws cli)
2) Rename `backend.tmp` to `backend.tf` and edit `bucket`, `region`, `profile` values inside. 
3) Edit `tfvarf/*.tfars` and change also all needed values


### Usage
- After editing tfvars do not forget use `bash upload-tfvars.sh` to upload trfars file to bucket.
- If you need to deploy then use `bash deploy.sh` script.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | cloudposse/ec2-instance/aws | 0.45.2 |
| <a name="module_ec2_label"></a> [ec2\_label](#module\_ec2\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | cloudposse/dynamic-subnets/aws | 2.0.4 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | cloudposse/vpc/aws | 1.1.1 |
| <a name="module_vpc_label"></a> [vpc\_label](#module\_vpc\_label) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_ipv4_cidr_block_association.secondary_ipv4_cidr](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [random_integer.octet1](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_integer.octet2](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile_name"></a> [aws\_profile\_name](#input\_aws\_profile\_name) | n/a | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_chain_name"></a> [chain\_name](#input\_chain\_name) | n/a | `string` | n/a | yes |
| <a name="input_eks_node_groups"></a> [eks\_node\_groups](#input\_eks\_node\_groups) | n/a | <pre>list(object({<br>    name                = optional(string, "default")<br>    desired_size        = optional(number, "3")<br>    min_size            = optional(number, "3")<br>    max_size            = optional(number, "11")<br>    disk_size           = optional(number, "20")<br>    multi_az            = optional(bool, "true")<br>    kubernetes_version  = optional(string, "1.23")<br>    capacity_type       = optional(string, "ON_DEMAND")<br>    instance_types      = optional(list(string), ["t3.medium"])<br>    ami_release_version = optional(list(string), [])<br>    arch                = optional(string, "amd64")<br>    kubernetes_labels   = optional(map(string), {"node-group-purpose" = "default"})<br>  }))</pre> | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | n/a |
| <a name="output_ec2_ip_address"></a> [ec2\_ip\_address](#output\_ec2\_ip\_address) | n/a |
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | n/a |
<!-- END_TF_DOCS -->
