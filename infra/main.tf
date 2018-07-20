provider "kubernetes" {
  host     = "https://35.224.137.161"
  username = "admin"
  password = "9AlygNOPh6dCFFXW"
}

resource "kubernetes_pod" "demo-service" {
  metadata {
    name = "demo"
  }

  spec {
    container {
      image = "gcr.io/development-207315/demo-service:2795f9564962ba21197b49eb0ceca9e486f7e2f5"
      name  = "demo-service"
    }
  }
}
