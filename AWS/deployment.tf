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
          args = ["--collator", "--rpc-cors=all", "--name ${var.node_name}", "--chain ${var.chain_name}", "--base-path /data", "--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0'", "--execution wasm"]

          security_context {
            run_as_non_root = "true"
          }

          volume_mount {
            mount_path = "/var/lib/astar/"
#            sub_path = "/var/lib/astar"
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
        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = "data"
          }
        }
      }
    }
  }
  depends_on = [time_sleep.eks_node_groups_wait]
}