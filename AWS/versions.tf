terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }

#    null = {
#      source  = "hashicorp/null"
#      version = "3.2.1"
#    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}
