# GCP Deployment

## Pre-requirements
1. Installed [gcloud CLI](https://cloud.google.com/sdk/docs/install)
2. Authorized gcloud SDK
```commandline
gcloud init
gcloud auth application-default login
```
3. [Optionally] Installed kubectl for interacting with EKS

## Usage
### Configuration
1. Configure variables in [terraform.tfvars](GCP/terraform.tfvars)
 - `project_name` - AWS organization project name;
 - `region` - AWS deployment region, default is `eu-central-1`;

 - `docker_image` - docker image of the collator;
 - `container_args` - collator arguments are specific to collator you spinning up; no spaces allowed in arguments - separate them with `", "` instead of spaces;
 - `container_command` - command bypassed to collator container.

2. Configure container ports with `container_args` in [terraform.tfvars](GCP/terraform.tfvars) if your collator don't use defaults ports `30333`, `9933`, `9944`

### Optional Configurations
1. Configure variables in [backend.tf](GCP/backend/backend.tf)
- `bucket` - bucket name where tfvars are stored;

2. Configure deployment parameters for GKE cluster in [gke-cluster.tf](GCP/gke-cluster.tf) 
 - `min_master_version` - minimal kubernetes version for master, GCP will update it automatically, and we can't prevent it
 - `disk_size_gb`       - disk size of each GKE node
 - `cluster_cidr`       - cidr for GKE cluster, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `cluster_cidr`
 - `services_cidr`      - cidr for GKE services, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `services_cidr`
 - `master_cidr`        - cidr for GKE master nodes, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `master_cidr`
 - `machine_type`       - node vm type
 - `nodes_number`       - initial nodes number
 - `total_min_nodes`    - min nodes number for autoscaler
 - `total_max_nodes`    - max nodes number for autoscaler, quota 8 for basic accounts

<details>
  <summary>WARN</summary>
    After any changes, GKE cluster is re-created
</details>

### Deployment
Once you have configured everything follows steps below to deploy collator
- Install all dependecies with `terraform init`
- Check deployment with `terraform plan`
- If everything is planned correctly apply deployment with `terraform apply`
- `optional` copy file [backend.tf](GCP/backend/backend.tf) to GCP if you need to store tfstate in the google storage bucket
- Verify that your node is syncing via [telemetry](https://telemetry.polkadot.io/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.51.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.18.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow-all](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_firewall) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_network) | resource |
| [google_compute_route.egress_internet](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_route) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_subnetwork) | resource |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/container_cluster) | resource |
| [google_container_node_pool.primary_nodes](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/container_node_pool) | resource |
| [google_storage_bucket.backend](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.default](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/storage_bucket_object) | resource |
| [kubernetes_deployment.collator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_args"></a> [container\_args](#input\_container\_args) | n/a | `list(string)` | n/a | yes |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | n/a | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | n/a | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"us-central1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
