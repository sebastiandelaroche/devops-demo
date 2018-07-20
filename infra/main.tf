provider "kubernetes" {
  host     = "${var.cluster_kubernetes_host}"
  username = "${var.cluster_kubernetes_username}"
  password = "${var.cluster_kubernetes_password}"
}

resource "kubernetes_pod" "example" {
  metadata {
    name = "terraform-example"

    labels {
      app = "MyApp"
    }
  }

  spec {
    container {
      image = "gcr.io/${var.gcp_project}/${var.image_name}:${var.circle_sha1}"
      name  = "example"
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    selector {
      app = "${kubernetes_pod.example.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
