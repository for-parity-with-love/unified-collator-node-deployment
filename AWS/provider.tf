provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile_name
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

provider "helm" {
  debug = true
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.eks_cluster_id]
      command     = "aws"
    }


    # If Helm provider unable to reach k8s cluster, uncomment this
    #config_path    = "~/.kube/config"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--region", var.aws_region, "--cluster-name", module.eks_cluster.eks_cluster_id]
    command     = "aws"
  }

    # If kubernetes provider unable to reach k8s cluster, uncomment this
    #config_path    = "~/.kube/config"
}
