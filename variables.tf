variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "argocd_url" {
  type = string
}

variable "root_domain" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

variable "rds_password" {
  type      = string
  sensitive = true
}

variable "rds_db_name" {
  type      = string
  sensitive = true
}

variable "rds_username" {
  type      = string
  sensitive = true
}

variable "slack_workspace_id" {
  type      = string
}

variable "slack_token" {
  type = string
}

variable "rds_allocated_storage" {
  type = string
}

variable "rds_max_allocated_storage" {
  type = string
}

variable "rds_multi_az" {
  type = string
}

variable "rds_storage_type" {
  type = string
}

variable "rds_iops" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_backup_retention_period" {
  type = string
}

variable "redis-node-type" {
  type = string
}

variable "redis-parametr-group-name" {
  type = string
}

variable "redis-node-groups" {
  type = string
}

variable "redis-engine-version" {
  type = string
}

variable "backend_url" {
  type = string
}

variable "frontend_url" {
  type = string
}

variable "pay_url" {
  type = string
}

variable "dash_url" {
  type = string
}

variable "app_url" {
  type = string
}

variable "blog_url" {
  type = string
}

variable "azondo_subnet_private_cidrs" {
  type = list
  default = []
}
variable "azondo_subnet_public_cidrs" {
  type = list
  default = []
}

variable "eks_node_groups" {
  type = list(object({
    name                = optional(string, "default")
    desired_size        = optional(number, "3")
    min_size            = optional(number, "3")
    max_size            = optional(number, "11")
    disk_size           = optional(number, "20")
    multi_az            = optional(bool, "true")
    kubernetes_version  = optional(string, "1.23")
    capacity_type       = optional(string, "ON_DEMAND")
    instance_types      = optional(list(string), ["t3.medium"])
    ami_release_version = optional(list(string), [])
    arch                = optional(string, "amd64")
    kubernetes_labels   = optional(map(string), {"node-group-purpose" = "default"})
  }))
}

variable "cloudwatch_alerts" {
  type = list
}
