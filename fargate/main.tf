variable "aws_profile" {
}

provider "aws" {
  version = ">= 2.27.0"
  region  = var.region
  profile = var.aws_profile
}

output "aws_profile" {
  value = var.aws_profile
}
