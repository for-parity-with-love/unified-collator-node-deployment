resource "kubernetes_deployment_v1" "astar" {
  count = local.environment == "astar" ? "1" : "0"

  metadata {
    name = var.project_name
    labels = {
      name = var.project_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = var.project_name
      }
    }

    template {
      metadata {
        labels = {
          name = var.project_name
        }
      }

      spec {
        container {
          image = "${var.docker_image}"
          name  = var.project_name
          command = ["${var.container_command}"]
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
  depends_on = [time_sleep.eks_node_groups_wait, aws_eks_addon.coredns]
}

resource "kubernetes_deployment_v1" "moonbeam" {
  count = local.environment == "moonbeam" ? "1" : "0"

  metadata {
    name = var.project_name
    labels = {
      name = var.project_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = var.project_name
      }
    }

    template {
      metadata {
        labels = {
          name = var.project_name
        }
      }

      spec {
        container {
          image = "${var.docker_image}"
          name  = var.project_name
          args = ["--collator", "--rpc-cors=all", "--name", "${var.node_name}", "--chain", "${var.chain_name}", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm", "--wasm-execution","compiled"]

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
  depends_on = [time_sleep.eks_node_groups_wait, aws_eks_addon.coredns]
}

resource "kubernetes_deployment_v1" "karura" {
  count = local.environment == "karura" ? "1" : "0"

  metadata {
    name = var.project_name
    labels = {
      name = var.project_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = var.project_name
      }
    }

    template {
      metadata {
        labels = {
          name = var.project_name
        }
      }

      spec {
        container {
          image = "${var.docker_image}"
          name  = var.project_name
          args = ["--collator", "--name", "${var.node_name}", "--chain", "${var.chain_name}", "--execution", "wasm"]

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
  depends_on = [time_sleep.eks_node_groups_wait, aws_eks_addon.coredns]
}