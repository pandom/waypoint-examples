project = "learn-dynamic-go"

app "dynamic-go" {
  labels = {
    "service" = "dynamic-go",
  }

  config {
    env = {
      "USERNAME" = dynamic("vault", {
        path = "database/creds/accessdb"
        key  = "username"
      })
      "PASSWORD" = dynamic("vault", {
        path = "database/creds/accessdb"
        key  = "password"
      })
    }
  }

  build {
    use "pack" {}
  }

  deploy {
    use "docker" {}
  }
}
