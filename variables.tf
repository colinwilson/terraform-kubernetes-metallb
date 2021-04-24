# Required configuration variables

# Optional configuration
variable "metallb_version" {
  default     = "0.9.6"
  type        = string
  description = "MetalLB Version e.g. 0.9.6"
}

variable "controller_toleration" {
  default = []
  type    = list(map(any))
}

variable "controller_node_selector" {
  default = {}
  type    = map(any)
}