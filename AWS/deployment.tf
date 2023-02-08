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
          command = ["astar-collator"]
          args = ["--collator", "--rpc-cors=all", "--name", "${local.environment}-collator", "--chain", "astar", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm"]

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
  depends_on = [module.eks_node_groups, aws_eks_addon.coredns]
}