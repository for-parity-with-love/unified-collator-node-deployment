data "google_client_config" "provider" {}

provider "kubernetes" {
  host  = "https://${google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

resource "kubernetes_deployment" "collator" {
  metadata {
    name = "${var.project_name}"
    labels = {
      name = "${var.project_name}"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "${var.project_name}"
      }
    }

    template {
      metadata {
        labels = {
          name = "${var.project_name}"
        }
      }

      spec {
        container {
          image   = var.docker_image
          name    = var.project_name
          args    = var.container_args
          #command = var.container_command

          security_context {
            privileged = true
          }

          port {
            container_port = 30333
          }

          port {
            container_port = 9933
          }

          port {
            container_port = 9944
          }
        }
      }
    }
  }
  depends_on = [google_container_node_pool.primary_nodes]
}
