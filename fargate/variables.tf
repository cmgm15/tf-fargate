variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
}

variable "app" {
}

variable "environment" {
}

variable "container_port" {
}

variable "lb_port" {
  default = "80"
}

variable "lb_protocol" {
  default = "HTTP"
}

variable "vpc" {
}

variable "private_subnets" {
}

variable "public_subnets" {
}
