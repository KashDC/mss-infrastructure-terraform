terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.6.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "DigitalCatapult"
    workspaces{
      prefix = "sampleui"
    }
  }

}