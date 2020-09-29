# Create Controller Cluster Role Binding Role
resource "kubernetes_cluster_role_binding" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:controller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Speaker Cluster Role Binding Role
resource "kubernetes_cluster_role_binding" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:speaker"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:speaker"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "speaker"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}