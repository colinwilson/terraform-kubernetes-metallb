# Create Config Watcher Role
resource "kubernetes_role" "config_watcher" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "config-watcher"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "list", "watch"]
  }
}

# Create Pod Lister Role
resource "kubernetes_role" "pod_lister" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "pod-lister"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["list"]
  }
}

resource "kubernetes_role" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["memberlist"]
    verbs          = ["list"]
  }

  rule {
    api_groups     = ["apps"]
    resources      = ["deployments"]
    resource_names = ["controller"]
    verbs          = ["get"]
  }
}