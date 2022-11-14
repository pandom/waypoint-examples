project = "nomad-nodejs"

# This will take build pack and compile a new image then deploy
// pipeline "full" {
//   step "build" {
//     use "build" {}
//   }
//   step "deploy"{
//     use "deploy" {}
//   }
// }

// # This will deploy latest and prune the old releases.
// pipeline "deploy" {
//   step "deploy" {
//     use "deploy" {}
//   }
//   step "prune" {
//     use "release" {
//         prune = true
//         prune_retain = 3
//       }
//   }
// }

pipeline "full-up" {
  step "my-build" {
    use "build" {}
  }

  step "my-deploy" {
    use "deploy" {}
  }

  step "my-release" {
    use "release" {
      prune = true
      prune_retain = 1
    }
  }
}

app "nomad-nodejs-web" {
  runner {
    prfile = "nomad-01GHSTM8M4YG3KDZPW5VQFJNH7"
  }
  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "nomad-nodejs-web"
        tag   = "1"
        local = true
      }
    }
  }

  deploy {
    use "nomad" {
      // these options both default to the values shown, but are left here to
      // show they are configurable
      datacenter       = "dc1"
      namespace        = "default"
      service_provider = "nomad"

    }
  }
  release {
    prune = false
    prune_retain = 3
  }


}
