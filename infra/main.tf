provider "kubernetes" {
  host     = "https://35.224.137.161"
  username = "admin"
  password = "9AlygNOPh6dCFFXW"
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
      image = "gcr.io/${var.GCP_PROJECT}/${var.IMAGE_NAME}:${var.CIRCLE_SHA1}"
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
