variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Profile to use from ~/.aws/credentials"
}

variable "owner" {
  type = string
  description = "The owner username of the remote state bucket"
}

variable "app" {
  type = string
}

variable "tags" {
  type = map(string)
}
