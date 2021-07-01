# Create Controller Cluster Role
resource "kubernetes_cluster_role" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:controller"
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = [""]
    resources  = ["services/status"]
    verbs      = ["update"]

  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]

  }

  rule {
    api_groups     = ["policy"]
    resource_names = ["controller"]
    resources      = ["podsecuritypolicies"]
    verbs          = ["use"]

  }
}

# Create Speaker Cluster Role
resource "kubernetes_cluster_role" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:speaker"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "nodes"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]

  }

  rule {
    api_groups     = ["policy"]
    resource_names = ["speaker"]
    resources      = ["podsecuritypolicies"]
    verbs          = ["use"]

  }
}