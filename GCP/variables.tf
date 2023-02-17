variable "node_name" {
  description = "collator node name"
}

variable "chain_name" {
  description = "collator chain name"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
  default = "us-central1"
}

variable "container_command" {
  default = ""
  type = string
}

variable "docker_image" {
  type = string
}

variable "project_name" {
  type = string
}
