resource "google_compute_network" "vpc" {
  name                            = "${var.project_id}-vpc"
  auto_create_subnetworks         = "false"
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_route" "egress_internet" {
  name             = "egress-internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_router" "router" {
  name    = "${var.project_id}-router"
  region  = var.region
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat" {
  name   = "${var.project_id}-nat"
  router = google_compute_router.router.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "AUTO_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}

resource "google_compute_firewall" "allow-all" {
  name    = "allow-all"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  
  allow {
    protocol = "tcp"
    ports    = ["30333"]
  }
  
  allow {
    protocol = "tcp"
    ports    = ["9933"]
  }
  
  allow {
    protocol = "tcp"
    ports    = ["9944"]
  }

  source_ranges = ["0.0.0.0/0"]
}
