variable "aws_region" {
  type = string
}

variable "node_name" {
  type = string
}

variable "aws_profile_name" {
  type = string
}

variable "container_command" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "chain_name" {
  type = string
}

variable "project_name" {
  type = string
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
