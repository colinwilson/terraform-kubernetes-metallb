# Create Config Watcher Role Binding
resource "kubernetes_role_binding" "config_watcher" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "config-watcher"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "config-watcher"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Pod Lister Role Binding
resource "kubernetes_role_binding" "pod_lister" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "pod-lister"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "pod-lister"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Controller Role Binding
resource "kubernetes_role_binding" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}