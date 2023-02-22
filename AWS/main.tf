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
  depends_on = [time_sleep.eks_node_groups_wait, aws_eks_addon.coredns]
}
