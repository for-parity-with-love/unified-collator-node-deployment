# GCP infrastructure

### Pre-requirements
1) GCP account
2) Configured gcloud SDK
3) Installed kubectl

Login to gcloud SDK
```commandline
gcloud init
gcloud auth application-default login
```

### Run collator

Configure variables in [terraform.tfvars](GCP/terraform.tfvars)
`project_id` - GCP organization project ID
`region`     - GCP deployment region
`chain_name` - the name of collator chain
`node_name`  - unique node name



Configure deployment in [terraform.tfvars](GCP/kubernetes.tf)
  `image` - docker image for the collator
  `command` - collator command name
  `args` - collator arguments, no spaces allowed in arguments - separate them with `", "` instead of spaces



`optional` configure deployment parameters for GKE cluster in [gke-cluster.tf](GCP/gke-cluster.tf)
  `min_master_version` - minimal kubernetes version for master, GCP will update it automatically, and we can't prevent it
  `disk_size_gb`       - disk size of each GKE node
  `cluster_cidr`       - cidr for GKE cluster, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `cluster_cidr`
  `services_cidr`      - cidr for GKE services, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `services_cidr`
  `master_cidr`        - cidr for GKE master nodes, make sure to edit cidr in [network.tf](GCP/network.tf) if editing `master_cidr`
  `machine_type`       - node vm type
  `nodes_number`       - initial nodes number
  `total_min_nodes`    - min nodes number for autoscaler
  `total_max_nodes`    - max nodes number for autoscaler, quota 8 for basic accounts



Run deployment
```commandline
terraform apply
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_gcloud"></a> [gcloud](#requirement\_gcloud) | 418.0.0 |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google ](#provider\_google ) | 4.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |


## Resources

| Name | Type |
|------|------|
| [random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_container_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [kubernetes_deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_route](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_client_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
