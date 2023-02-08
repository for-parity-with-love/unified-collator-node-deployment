locals {
  deployment_name = "collator"
}

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
    name = "${local.deployment_name}"
    labels = {
      name = "${local.deployment_name}"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "${local.deployment_name}"
      }
    }

    template {
      metadata {
        labels = {
          name = "${local.deployment_name}"
        }
      }

      spec {
        container {
          image = "staketechnologies/astar-collator:latest"
          name  = "${local.deployment_name}"
          command = ["astar-collator"]
          args = ["--collator", "--rpc-cors=all", "--name", "${var.node_name}", "--chain", "${var.chain_name}", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm"]

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
