# infrastructure by Terraform

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
