
provider "aws" {
  region = var.region
  profile = "default"
  alias = "default"
}
#provider "docker" {
#  host = "unix:///var/run/docker.sock"
#}

provider "docker" {
  registry_auth {
    address  = local.aws_ecr_url
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password

  }

}

