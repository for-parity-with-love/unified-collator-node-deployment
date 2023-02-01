# infrastructure by Terraform

### Pre-requirments
1) a GCP account
2) a configured gcloud SDK
3) kubectl

Edit `terraform.tfvars` and
```commandline
terraform apply

```

To configure kubectl
```commandline
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

```
