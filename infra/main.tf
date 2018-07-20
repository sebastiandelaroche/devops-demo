provider "kubernetes" {
  host     = "https://35.224.137.161"
  username = "admin"
  password = "9AlygNOPh6dCFFXW"
}

resource "kubernetes_pod" "demo-service" {
  metadata {
    name = "demo"

    labels {
      app = "demo-service"
    }
  }

  spec {
    container {
      image = "gcr.io/development-207315/demo-service:2795f9564962ba21197b49eb0ceca9e486f7e2f5"
      name  = "demo-service"
    }
  }
}

resource "kubernetes_service" "demo-service" {
  metadata {
    name = "demo"
  }

  spec {
    selector {
      app = "${kubernetes_pod.demo-service.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port        = 8080
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
