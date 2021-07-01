# Create Controller Pod Security Policy
resource "kubernetes_pod_security_policy" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "controller"
    #namespace = "metallb-system"
  }
  spec {
    allow_privilege_escalation = false
    allowed_capabilities       = []
    #allowed_host_paths {}
    default_add_capabilities           = []
    default_allow_privilege_escalation = false

    fs_group {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    host_ipc                   = false
    host_network               = false
    host_pid                   = false
    privileged                 = false
    read_only_root_filesystem  = true
    required_drop_capabilities = ["ALL"]

    run_as_user {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    volumes = [
      "configMap",
      "secret",
      "emptyDir",
    ]
  }
}

# Create Speaker Pod Security Policy
resource "kubernetes_pod_security_policy" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "speaker"
    #namespace = "metallb-system"
  }
  spec {
    allow_privilege_escalation = false
    allowed_capabilities       = ["NET_RAW"]
    #allowed_host_paths {}
    default_add_capabilities           = []
    default_allow_privilege_escalation = false

    fs_group {
      rule = "RunAsAny"
    }

    host_ipc     = false
    host_network = true
    host_pid     = false

    host_ports {
      max = 7472
      min = 7472
    }

    host_ports {
      max = 7946
      min = 7946
    }

    privileged                 = true
    read_only_root_filesystem  = true
    required_drop_capabilities = ["ALL"]

    run_as_user {
      rule = "RunAsAny"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "RunAsAny"
    }

    volumes = [
      "configMap",
      "secret",
      "emptyDir",
    ]
  }
}
