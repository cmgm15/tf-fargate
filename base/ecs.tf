resource "aws_ecs_cluster" "app" {
  name = var.app
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = var.tags
}
