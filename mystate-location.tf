terraform {
  cloud {
    organization = "humayunalam"

    workspaces {
      name = "aws-cicd"
    }
  }
}
