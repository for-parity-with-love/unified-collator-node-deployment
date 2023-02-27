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
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"us-central1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->