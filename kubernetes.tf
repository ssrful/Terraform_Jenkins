terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "terraform_kubernetes" "flask" {
  metadata {
    name = "terraform_kubernetes"
    labels {
      App = "terraform_kubernetes"
    }
  }
}
spec {
  replicas = 3
  selector {
    match_labels = {
      app = "Flask-App"
      }
    }
    template {
      metadata {
        labels = {
          app = "Flask-App"
          }
        }
      }  
    port {
      container_port = 80
    }
  }
  spec {
    image = "ssrful/terraform-flask"
    name = "Flask-App"
  }
  resources {
    limits = {
      cpu    = "0.5"
      memory = "512Mi"
      }
    requests = {
      cpu    = "250m"
      memory = "50Mi"
    }
  }  
resource "terraform_kubernetes_service" "flask" {
  metadata {
    name = "terraform_kubernetes_svc"
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 32001
      port        = 80
      target_port = 80
    }
  }
}