project = "nomad-nodejs"

app "nomad-nodejs-web" {

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "localhost:5000/nomad-nodejs-web"
        tag   = "1"
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
