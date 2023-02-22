variable "region" {
  description = "GCP region"
  default = "us-central1"
}

variable "project_name" {
  type = string
}

variable "container_command" {
  default = [""]
  type = list(string)
}

variable "docker_image" {
  type = string
}

variable "container_args" {
  type = list(string)
}