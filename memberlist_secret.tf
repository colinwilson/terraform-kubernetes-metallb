# Create memberlist communications secretkey
# No longer required since v0.10.0
# See - https://metallb.universe.tf/release-notes/#version-0-10-0

# resource "random_password" "memberlist_secretkey" {
#   length = 128
# }

# resource "kubernetes_secret" "memberlist" {
#   metadata {
#     name      = "memberlist"
#     namespace = kubernetes_namespace.metallb_system.metadata.0.name
#   }

#   data = {
#     secretkey = base64encode(random_password.memberlist_secretkey.result)
#   }
# }