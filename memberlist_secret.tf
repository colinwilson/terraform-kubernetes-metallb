# Create memberlist communications secretkey
resource "random_id" "memberlist_secretkey" {
  byte_length = 128 # WARNING! Output shown in console!
}

resource "kubernetes_secret" "memberlist" {
  metadata {
    name = "memberlist"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  data = {
    secretkey = random_id.memberlist_secretkey.b64_std
  }
}