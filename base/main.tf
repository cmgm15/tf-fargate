terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = ">= 2.23.0"
  region  = var.region
  profile = var.aws_profile
}

output "docker_registry" {
  value = aws_ecr_repository.app.repository_url
}

output "remote_state_bucket" {
  value = module.remote_state.remote_state_bucket
}
