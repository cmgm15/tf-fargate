variable "cicd_environments" {
  type        = list(string)
  description = "Environments that CICD users should have permissions for build and deploy"
  default = [
    "dev",
    "qa"
  ]
}

variable "cicd_user" {
  type        = bool
  description = "Boolean to decide if the env needs cicd_user"
  default     = true
}

resource "aws_iam_user" "cicd" {
  count = var.cicd_user : 1 ? 0
  name  = "cicd_${var.app}_${var.cicd_environments}"
}

resource "aws_iam_access_key" "cicd_keys" {
  count = var.cicd_user : 1 ? 0
  user = aws_iam_user.cicd.name
}

data "aws_iam_policy_document" "cicd_policy" {
  count = var.cicd_user : 1 ? 0
  statement {
    sid = "ecr"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]

    resources = [
      data.aws_ecr_repository.ecr.arn,
    ]
  }

  statement {
    sid = "ecs"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:UpdateService",
      "ecs:RegisterTaskDefinition",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "approle"

    actions = [
      "iam:PassRole",
    ]

    resources = [
      aws_iam_role.app_role.arn,
      aws_iam_role.ecsTaskExecutionRole.arn,
    ]
  }
}

resource "aws_iam_user_policy" "cicd_user_policy" {
  count = var.cicd_user : 1 ? 0
  name   = "${var.app}_${var.environment}_cicd"
  user   = aws_iam_user.cicd.name
  policy = data.aws_iam_policy_document.cicd_policy.json
}

data "aws_ecr_repository" "ecr" {
  count = var.cicd_user : 1 ? 0
  name = var.app
}

output "cicd_keys" {
  value = "terraform state show aws_iam_access_key.cicd_keys"
}

output "docker_registry" {
  value = data.aws_ecr_repository.ecr.repository_url
}