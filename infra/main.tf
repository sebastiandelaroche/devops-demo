provider "kubernetes" {
  host     = "https://35.224.137.161"
  username = "admin"
  password = "9AlygNOPh6dCFFXW"
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
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
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
      image = "gcr.io/development-207315/demo-service:2795f9564962ba21197b49eb0ceca9e486f7e2f5"
      name  = "example"
    }
  }
}
