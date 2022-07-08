project = "example-nodejs"

runner {
  enabled = true
  profile = "nomad-bootstrap-profile"
  data_source "git" {
    url  = "https://github.com/hashicorp/waypoint-examples.git"
    path = "nomad/nodejs"
    ref = "docker-pull-remote-test"
  }
}	

app "example-nodejs" {
  runner {
    enabled = true
    profile = "nomad-bootstrap-profile"
    data_source "git" {
      url  = "https://github.com/hashicorp/waypoint-examples.git"
      path = "nomad/nodejs"
      ref = "docker-pull-remote-test"
    }
  }

  build {
    use "docker-pull" {
      image              = "node"
      tag                = "latest"
    }
    registry {
      use "docker" {
        image = "devopspaladin/nodejs-example"
        tag   = "very-latest"
        auth {
          username = var.user
          password = var.pass
        }
      }
    }
  }

  deploy {
    use "nomad" {
      // these options both default to the values shown, but are left here to
      // show they are configurable
      datacenter = "dc1"
      namespace  = "default"
    }
  }
}

variable "user" {
  type      = string
  sensitive = true
}

variable "pass" {
  type      = string
  sensitive = true
}
