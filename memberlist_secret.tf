# Create memberlist communications secretkey
resource "random_password" "memberlist_secretkey" {
  length = 128 # WARNING! Output shown in console!
}

resource "kubernetes_secret" "memberlist" {
  metadata {
    name      = "memberlist"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  data = {
    secretkey = base64encode(random_password.memberlist_secretkey.result)
  }
}