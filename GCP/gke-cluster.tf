terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
  }

  required_version = ">= 0.14"
}


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

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# Router
resource "google_compute_router" "router" {
  name    = "${var.project_id}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

# NAT
resource "google_compute_router_nat" "nat" {
  name   = "${var.project_id}-nat"
  router = google_compute_router.router.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_compute_subnetwork.subnet]
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  node_version = "1.24"
  min_master_version = "1.24"
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  node_config {
    disk_size_gb = 20
  }
  
  node_locations = [
    "${var.region}-a",
    "${var.region}-b",
    "${var.region}-c"
  ]
  
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  management {
    auto_repair  = true
    auto_upgrade = true
  }
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }
    
    machine_type = "e2-medium"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  autoscaling {
    min_node_count = 3
	max_node_count = 11
  }
  create_before_destroy = true
}


# # Kubernetes provider
# # The Terraform Kubernetes Provider configuration below is used as a learning reference only. 
# # It references the variables and resources provisioned in this file. 
# # We recommend you put this in another file -- so you can have a more modular configuration.
# # https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider.

provider "kubernetes" {
  load_config_file = "false"

  host     = google_container_cluster.primary.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}

resource "kubernetes_deployment_v1" "collator" {
  metadata {
    name = "collator"
    labels = {
      name = "collator"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "collator"
      }
    }

    template {
      metadata {
        labels = {
          name = "collator"
        }
      }

      spec {
        container {
          image = "staketechnologies/astar-collator:latest"
          name  = "collator"
          args = ["astar-collator --collator", "--rpc-cors=all", "--name ${var.node_name}", "--chain ${var.chain_name}", "--base-path /data", "--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0'", "--execution wasm"]

          security_context {
            privileged = true
          }

          volume_mount {
            mount_path = "/var/lib/astar/"
            name       = "data"
          }

          port {
            container_port = 30333
            name = "port30333"
          }

          port {
            container_port = 9933
            name = "port9933"
          }

          port {
            container_port = 9944
            name = "port9944"
          }
        }
      }
    }
  }
  depends_on = [google_container_node_pool.primary_nodes]
}
