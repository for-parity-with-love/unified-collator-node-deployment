locals {
  min_master_version = "1.24"
  disk_size_gb = 500
  cluster_cidr = "10.101.0.0/16"
  services_cidr = "10.102.0.0/16"
  master_cidr = "10.100.100.0/28"
  machine_type = "e2-medium"
  nodes_number = 1
  total_min_nodes = 1
  total_max_nodes = 1 #quota 8 for basic accounts
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_name}-gke"
  min_master_version = "${local.min_master_version}"
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  node_config {
    disk_size_gb = local.disk_size_gb
  }
  
  ip_allocation_policy {
    cluster_ipv4_cidr_block = "${local.cluster_cidr}"
    services_ipv4_cidr_block = "${local.services_cidr}"
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
  
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "${local.master_cidr}"
  }
  
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = local.nodes_number

  management {
    auto_repair  = false
    auto_upgrade = false
  }
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    disk_size_gb = local.disk_size_gb

    labels = {
      env = var.project_name
      cluster = google_container_cluster.primary.name
    }
    
    machine_type = "${local.machine_type}"
    tags         = ["gke-node", "${var.project_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  autoscaling {
    total_min_node_count = local.total_min_nodes
    total_max_node_count = local.total_max_nodes
  }
}
